import 'package:epharm_movil/router/app_routes.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides(); 
  //Stripe.publishableKey = 'pk_live_51PCpCoP67FKnvrAb8Epif3BxJmxiiZno0mDaq0xQRGUDIQEQX27fSE6RHafvlCPPMgWlA655MDCkchFISgq3og7100cZDmHsW1';
  Stripe.publishableKey = 'pk_test_51PCpCoP67FKnvrAbI6YKyJlAQzHnIETaixQq5mvQF6niuobCQbxDTO2gw2L2dPQXycP58QNpMeDRALYYfrgBUyzo00kyQenam3';
  runApp( AppState());
}

class AppState extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => ProductsService(), lazy: false,),
        //ChangeNotifierProvider(create: ( _ ) => CartService(), lazy: false),
        ChangeNotifierProvider(create: ( _ ) => CartService()),
        ChangeNotifierProvider(create: ( _ ) => PaymentService()),
      ],
      child: MyApp(),
    );
  }

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,

      scaffoldMessengerKey: NotificationsService.messengerKey, //!para poder mostrar los snapbars en cualquier lugar
      
      theme: AppTheme.lightTheme,
    );
  }
}