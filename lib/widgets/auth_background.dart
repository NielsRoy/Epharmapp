import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(4, 120, 87, 1),
      width: double.infinity, //hace que tome todo el ancho de la pantalla
      height: double.infinity, //hace que tome todo el alto de la pantalla
      child: Stack(
        children: [

          _PurpleBox(),

          _HeaderIcon(),

          child,
                    
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: const Image(image: AssetImage('assets/img/logo.png'), height: 190,)
        //child: const Icon(Icons.person_pin, color: Colors.white, size: 100,),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size; //obtiene las dimensiones del dispositivo actual

    return Container(
      width: double.infinity,
      height: size.height * 0.4, //40% del alto pantalla
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned( top: 90, left: 30, child: _Bubble()), //posiciona el widget en la posicion indicada segun el Stack
          Positioned( top: -40, left: -30, child: _Bubble()), 
          Positioned( top: -20, right: 100, child: _Bubble()), 
          Positioned( bottom: -50, left: 10, child: _Bubble()), 
          Positioned( bottom: 60, right: 30, child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(240, 240, 240, 1),
        Color.fromRGBO(243, 243, 243, 1),

        // Color.fromRGBO(63, 63, 159, 1),
        // Color.fromRGBO(90, 70, 178, 1),
      ]
    )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(4, 120, 87, 0.05)
      ),
    );
  }
}