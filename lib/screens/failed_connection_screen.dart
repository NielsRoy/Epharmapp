//Error al cargar
//Imagen
//    Alerta de Información 
//    Parece que tiene problemas con la conexión.
//    Intentelo de nuevo
//    Boton Cerrar
//Boton Intentelo de nuevo --> No botar al usuario

//Los servidores se encuentran en mantenimiento. Intenta ingresar más tarde.
//Boton Salir --> Botar al usuario
// Solo botar al usuario cuando el servidor esta caido o en mantenimiento

import 'package:flutter/material.dart';

class FailedConnectionScreen extends StatelessWidget {  
  final Function? onRetry;

  const FailedConnectionScreen({
    Key? key, 
    this.onRetry
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Error al cargar"),
            if (onRetry != null)
              TextButton(
                onPressed: () => onRetry!(), 
                child: const Text("Intentelo de nuevo")
              )
          ],
        ),
      )
    );
  }
}