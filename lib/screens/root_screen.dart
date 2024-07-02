import 'package:epharm_movil/screens/login_screen.dart';
import 'package:epharm_movil/screens/products_screen.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class RootScreen extends StatelessWidget {
  
  const RootScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<bool>(
        future: authService.validateLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                color: AppTheme.primaryColor,
                child: Stack(
                  children: <Widget>[
                    Container(color: AppTheme.primaryColor),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300),
                              color: Colors.white
                            ),
                          ),
                          const Image(image: AssetImage('assets/img/logo.png'), height: 275,)
                        ],
                      )
                    ),
                  ],
                ),
              ),
            );
            // return Stack(
            //   children: [
            //     Container(
            //       color: AppTheme.primaryColor,
            //       child: const Image(image: AssetImage('assets/img/logo.png'), height: 190,),
            //     )
            //   ],
            // );
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data == true) {
              return const ProductsScreen();
            } else {
              return const LoginScreen();
            }
          }
          }
        },
      )
    );
  }
}