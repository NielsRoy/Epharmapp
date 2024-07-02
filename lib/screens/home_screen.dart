import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epharm_movil/services/services.dart';


class HomeScreen extends StatelessWidget {
  
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); //Como no necesito redibujar este widget nunca, el listen sera false, para que no escuche ningun cambio que suceda en esa variable authService
    //final productService = Provider.of<ProductService>(context);

    //if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}