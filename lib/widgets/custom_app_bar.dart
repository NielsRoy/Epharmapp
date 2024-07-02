import 'package:epharm_movil/search/search_delegate.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double _height = 70.0;
  final bool? isHomeAppBar;

  const CustomAppBar({
    Key? key,
    this.isHomeAppBar = false
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(_height);  
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: (!isHomeAppBar!) 
      //   ? IconButton(
      //       icon: const Icon(Icons.arrow_back_ios_rounded,),// color: Colors.black,),
      //       onPressed: () => Navigator.popUntil(context, ModalRoute.withName('home')),
      //     )
      //   : null,
      toolbarHeight: _height,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        //padding: (isHomeAppBar!) ? const EdgeInsets.symmetric(horizontal: 18) : const EdgeInsets.only(right: 18),
        child: TextField(
          autofocus: false,
          readOnly: true,
          onTap: () {
            if (!isHomeAppBar!) {
              Navigator.pop(context);
            }
            showSearch(context: context, delegate: ProductSearchDelegate());
          },
          decoration: InputDecoration(
            hintText: (isHomeAppBar!) ? 'Marcas, categorías y productos' : '¿Qué estás buscando?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            suffixIcon: Container(
              //padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (isHomeAppBar!) ?AppTheme.primaryColor : Colors.white,
              ),
              child: Icon(Icons.search_rounded, size: 18.0, color: (isHomeAppBar!) ? Colors.white : Colors.black)
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              )
            ),
          ),
        ),
      ),
      /*
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: (isHomeAppBar!)
          ? IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded)
            )
          : IconButton(
              onPressed: () {},
              // onPressed: () {
              //   final productsService = Provider.of<ProductsService>(context, listen: false);
              //   productsService.getCartProducts();
              //   Navigator.pushNamed(context, 'cart', arguments: productsService.cartProducts);
              // },
              icon: const Icon(Icons.shopping_cart_outlined)
            )
          // child: Icon(
          //   (isHomeAppBar!) ? Icons.notifications_none_rounded : Icons.shopping_cart_outlined, 
          //   //color: Colors.black,
          // ),
        )
      ],*/
    );
  }

}