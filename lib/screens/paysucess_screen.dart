import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaysuccessScreen extends StatelessWidget {
  
  const PaysuccessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor, size: 150),
            const SizedBox(height: 20,),
            const Text('Pago exitoso', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'products'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor, // Fondo verde
                foregroundColor: Colors.white, // Texto blanco
              ),
              child: const Text(
                'Volver al inicio',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ),
    );
  }
}