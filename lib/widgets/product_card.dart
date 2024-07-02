import 'package:epharm_movil/models/models.dart';
import 'package:epharm_movil/services/notifications_service.dart';
import 'package:epharm_movil/services/services.dart';
// import 'package:epharm_movil/providers/providers.dart';
// import 'package:epharm_movil/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key, 
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'product_detail', arguments: product),
        child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                //color: Colors.red,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/img/jar-loading.gif'),
                          image: NetworkImage(product.fullImagenUrl),
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (product.stock > 0 && product.fechaExp.isAfter(today))
                      Positioned(
                        top: 0,
                        right: 10,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: IconButton(
                            //splashColor: Colors.red,
                            onPressed: () {
                              final cartService = Provider.of<CartService>(context, listen: false);
                              if (product.precioDescuento > -1){
                                cartService.addCartDetail(product.id, 1, product.precioDescuento);
                              }
                              else{
                                cartService.addCartDetail(product.id, 1, double.parse(product.precioventa));
                              }
                              NotificationsService.showSnackbar("Producto agregado al carrito");
                            },
                            icon: const Icon(Icons.add, size: 20, color: Colors.black,)
                          )
                        ),
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.stock <= 0)
                      const Text('*AGOTADO', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    if (product.fechaExp.isBefore(today))
                      const Text('*CADUCADO', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    
                    Text('Bs. ${product.precioventa}', style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500, decoration: (product.precioDescuento > -1) ? TextDecoration.lineThrough : TextDecoration.none),),
                    if (product.precioDescuento > -1)
                      Text('Bs. ${product.precioDescuento}', style: const TextStyle(color: Color.fromRGBO(4, 120, 87, 1), fontSize: 20, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),),
                    
                    Text(product.nombre, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    //Text("1un * Bs. 69,9/un", overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}