import 'package:epharm_movil/models/models.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  
  const ProductDetailScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final size = MediaQuery.of(context).size;
    DateTime today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              final cartService = Provider.of<CartService>(context, listen: false);
              cartService.loadCartDetails();
              Navigator.pushNamed(context, 'cart');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 22, 
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(product.fullImagenUrl),
                  height: size.height * 0.35,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Text(product.nombre, style: const TextStyle(fontSize: 22),),  //TODO: Revisar app peliculas en Deatil Screen para ver sobre textTheme.subtitle, headline5 , etc
                  const SizedBox(height: 5,),
                  Text('Bs. ${product.precioventa}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, decoration: (product.precioDescuento > -1) ? TextDecoration.lineThrough : TextDecoration.none),),
                  if (product.precioDescuento > -1)
                    const SizedBox(height: 5,),
                  if (product.precioDescuento > -1)
                    Text('Bs. ${product.precioDescuento}', style: const TextStyle(color: Color.fromRGBO(4, 120, 87, 1), fontSize: 26, fontWeight: FontWeight.w600),),

                  const SizedBox(height: 10,),
                  Text(product.descripcion, style: const TextStyle(fontSize: 16), maxLines: 4, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 5,),
                  Text('Laboratorio: ${product.laboratorio}', style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 5,),
                  Text('Categoría: ${product.categoria}', style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 5,),
                  Text('Disponibles: ${product.stock}', style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 5,),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductDetailNavigationBar(
        size: size,
        productId: product.id,
        price: (product.precioDescuento > -1) ? product.precioDescuento : double.parse(product.precioventa),
        stock: product.stock,
        expirado: today.isAfter(product.fechaExp)
      )
    );
  }
}