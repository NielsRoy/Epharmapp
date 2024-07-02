import 'package:epharm_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailNavigationBar extends StatefulWidget {
  const ProductDetailNavigationBar({
    Key? key,
    required this.size,
    required this.productId,
    required this.price, 
    required this.stock, 
    required this.expirado, 
  }) : super(key: key);

  final Size size;
  final int productId;
  final double price;
  final int stock;
  final bool expirado;

  @override
  State<ProductDetailNavigationBar> createState() => _ProductDetailNavigationBarState();
}

class _ProductDetailNavigationBarState extends State<ProductDetailNavigationBar> {
  int count = 1;
  
  void increase() {
    if (count == 10 || count == widget.stock) return;
    count++;
    setState(() {});
  }

  void decrease() {
    if (count == 1) return;
    count--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: 
        (widget.stock > 0) 
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        decrease();
                        //print("decementar cantidad");
                      },
                      icon: const Icon(Icons.remove, size: 22,),
                    ),
                    //const SizedBox(width: 10,),
                    Text('$count', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    //const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {
                        increase();
                      },
                      icon: const Icon(Icons.add, size: 22,),
                    ),
                  ],
                )
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(4, 120, 87, 1),
                  minimumSize: Size(widget.size.width * 0.55, 70),
                  maximumSize: Size(widget.size.width * 0.55, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                
                onPressed: () {
                  final cartService = Provider.of<CartService>(context, listen: false);
                  cartService.addCartDetail(widget.productId, count, widget.price);
                  if (count == 1) {
                    NotificationsService.showSnackbar("Producto agregado al carrito");
                  } else {
                    NotificationsService.showSnackbar("Productos agregados al carrito");
                  }
                },
                child: Text('Agregar Bs. ${ (widget.price * count).toStringAsFixed (2) }', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16))
              ),
            ],
          )
        : Center(
            child: Text(
              (widget.expirado) ? 'CADUCADO' : 'AGOTADO', 
              style: const TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.w500), 
              maxLines: 1, overflow: TextOverflow.ellipsis
            )
          )
    );
  }
}