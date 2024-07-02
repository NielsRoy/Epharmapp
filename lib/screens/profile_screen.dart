import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    const int currentIndex = 2;

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }, 
          child: const Text('Cerrar Sesión')
        )
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: currentIndex,),
    );
  }
}