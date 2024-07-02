import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex; 

  const CustomNavigationBar({
    Key? key, 
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      //padding: const EdgeInsets.symmetric(vertical: 7),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: ( ) => Navigator.pushReplacementNamed(context, 'products'),
              icon: const Icon(Icons.home_filled),
              //tooltip: 'Inicio',
              padding: EdgeInsets.zero,
            ),
            label: 'Inicio'
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: ( ) {
                final cartService = Provider.of<CartService>(context, listen: false);
                cartService.loadCartDetails();
                // Navigator.pushNamed(context, 'cart', arguments: cartService.cartDetails);
                Navigator.pushNamed(context, 'cart');
              },
              icon: const Icon(Icons.shopping_cart),
              //tooltip: 'Carrito',
              padding: EdgeInsets.zero,
            ),
            label: 'Carrito'
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: ( ) => Navigator.pushReplacementNamed(context, 'profile'),
              icon: const Icon(Icons.person),
              //tooltip: 'Mi Perfil',
              padding: EdgeInsets.zero,
            ),
            label: 'Perfil'
          ),
        ],
      ),
    );
  }
}