import 'package:epharm_movil/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'root';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'login'         : ( _ ) => const LoginScreen(),
    'register'      : ( _ ) => const RegisterScreen(),
    'home'          : ( _ ) => const HomeScreen(),
    'products'      : ( _ ) => const ProductsScreen(),
    'product_detail': ( _ ) => const ProductDetailScreen(),
    'cart'          : ( _ ) => const CartScreen(),
    'profile'       : ( _ ) => const ProfileScreen(),
    'root'          : ( _ ) => const RootScreen(),
    'pedido'        : ( _ ) => const PedidoScreen(),
    'payment'       : ( _ ) => const PaymentScreen(),
    'paysuccess'    : ( _ ) => const PaysuccessScreen(),
    'pagoprueba'    : ( _ ) => const PagopruebaScreen(),
    //'failed_connection': ( _ ) => const FailedConnectionScreen(),
  };


}