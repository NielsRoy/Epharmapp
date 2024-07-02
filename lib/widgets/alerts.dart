import 'package:flutter/material.dart';

class Alerts {
  
  static void messageDialog(BuildContext context, String title, String message, String route)
  {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, route),
              child: const Text('Reintentar')
            )
          ],
        );
      }
    );
  }

}