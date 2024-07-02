import 'dart:convert';

import 'package:epharm_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:epharm_movil/services/api_config.dart';

class CartService extends ChangeNotifier {

  final String _baseUrl = ApiConfig.baseUrl;
  final storage = const FlutterSecureStorage();

  List<CartDetail> cartDetails = [];
  double total = 0;

  // CartService() {
  //   loadCartDetails();
  // }


  void loadCartDetails() async {
    final clienteId = await storage.read(key: 'cliente_id') ?? '';

    final url = Uri.http(_baseUrl, '/api/carrito/cliente/$clienteId');
    final resp = await http.get(url);
    Cart cart = Cart.fromRawJson(resp.body);
    total = double.parse(cart.total);
    cartDetails = cart.cartDetails;

    notifyListeners();
  }

  void updateCartDetail(int id, int cantidad, double precio) async {
    final Map<String, dynamic> data = {
      'cantidad': cantidad,
      'precio': precio,
    };
    final url = Uri.http(_baseUrl, '/api/carrito-detalle/$id');
    final resp = await http.put(
      url, 
      body: json.encode(data), 
      headers: {'Content-Type': 'application/json'}
    );
    
    
    // if (resp.statusCode == 200) {
    //   print('Datos actualizados correctamente.');
    // } else {
    //   print('Error al actualizar datos. Código de estado: ${resp.statusCode}');
    // }

  } 

  void deleteCartDetail(int id) async {
    final url = Uri.http(_baseUrl, '/api/carrito-detalle/$id');
    final resp = await http.delete(url);

    // notifyListeners();
    // if (resp.statusCode == 204) {
    //   print('Detalle eliminado correctamente.');
    // } else {
    //   print('Error al eliminar datos. Código de estado: ${resp.statusCode}');
    // }
  }

  void addCartDetail(int productId, int cantidad, double precio) async {
    final clienteId = await storage.read(key: 'cliente_id') ?? '';
    final Map<String, dynamic> data = {
      'producto_id': productId,
      'cantidad': cantidad,
      'precio': precio,
    };

    final url = Uri.http(_baseUrl, '/api/carrito/cliente/$clienteId');
    final resp = await http.post(
      url,
      body: json.encode(data), 
      headers: {'Content-Type': 'application/json'}
    );

  }
}