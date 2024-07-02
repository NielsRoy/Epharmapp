import 'dart:async';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PedidoScreen extends StatefulWidget {
  
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _lastPosition = LatLng(-17.783227231051523, -63.18223914392476);
  LatLng _currentPosition = LatLng(-17.783227231051523, -63.18223914392476);
  LatLng _pedidoPosition = LatLng(-17.783227231051523, -63.18223914392476);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLatLng(),
      builder: <LatLng> (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cargando...', style: TextStyle(color: Colors.black)),
              elevation: 1,
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          print('snapshot.data: ${snapshot.data.longitude} - ${snapshot.data.latitude}');

          return Scaffold(
            appBar: AppBar(
              title: const Text('Pedido', style: TextStyle(color: Colors.black)),
              elevation: 1,
              centerTitle: true,
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  //myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: snapshot.data,
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (position) => _pedidoPosition = position.target,
                ),
                Center(
                  child: Transform.translate(
                    offset: const Offset(0, -20),
                    child: const Icon(Icons.location_on, size: 50, color: AppTheme.primaryColor)
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _goToMyPosition,
              child: const Icon(Icons.my_location),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            bottomNavigationBar: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: TextButton(
                onPressed: () { 
                  PaymentService paymentService = Provider.of<PaymentService>(context, listen: false);
                  paymentService.payment.latitude = _pedidoPosition.latitude.toString();
                  paymentService.payment.longitude = _pedidoPosition.longitude.toString();
                  Navigator.pushNamed(context, 'payment');
                  //Navigator.pushNamed(context, 'pagoprueba');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Confirmar ubicación', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              )
            ),
          );
        }
      }
    );
  }

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<LatLng> getLatLng() async {
    try {
      Position position = await determinePosition();
      _pedidoPosition = LatLng(position.latitude, position.longitude);
      return LatLng(position.latitude, position.longitude);
    }
    catch (e) {
      print(e);
      return _lastPosition;
    }
  }

  Future<void> _goToMyPosition() async {
    _lastPosition = _currentPosition;
    _currentPosition = await getLatLng();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentPosition, zoom: 14.4746)));
  }
}