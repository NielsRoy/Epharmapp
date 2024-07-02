import 'package:epharm_movil/models/models.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void increase(CartService cartService, int index) {
    //if (product.cantidad == 10) return;
    CartDetail cartDetail = cartService.cartDetails[index];
    cartDetail.cantidad++;
    cartService.total += double.parse(cartDetail.precio);
    cartService.updateCartDetail(cartDetail.id, cartDetail.cantidad, double.parse(cartDetail.precio));
    
    setState(() {});
  }

  void decrease(CartService cartService, int index) {
    CartDetail cartDetail = cartService.cartDetails[index];
    if (cartDetail.cantidad == 1) return;
    cartDetail.cantidad--;
    cartService.total -= double.parse(cartDetail.precio);
    cartService.updateCartDetail(cartDetail.id, cartDetail.cantidad, double.parse(cartDetail.precio));

    setState(() {});
  }

  void eliminar(CartService cartService, int index) {
    CartDetail cartDetail = cartService.cartDetails[index];
    cartService.deleteCartDetail(cartDetail.id);
    cartService.cartDetails.removeAt(index);
    cartService.total -= (cartDetail.cantidad * double.parse(cartDetail.precio));
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    
    final cartService = Provider.of<CartService>(context);
    List<CartDetail> cartDetails = cartService.cartDetails;
    double total = cartService.total; 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito', style: TextStyle(color: Colors.black)),
        elevation: 1,
        centerTitle: true,
      ),
      body:
        (cartDetails.isEmpty)
        ? const Center(
            child: Image(image: AssetImage('assets/img/cartempty.png'), width: 200)
          )
        : ListView.separated(
          itemCount: cartDetails.length,
          itemBuilder: ( _ , index) {
            final cartDetail = cartDetails[index];
            final Product product = cartDetail.producto;
            final int cantidad = cartDetail.cantidad;
            final double price = double.parse(cartDetail.precio);
            
    
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) { //En esta funcion tambien podriamos restringir el swipe a una direccion
                eliminar(cartService, index);
              },
              child: ListTile(
                leading: Image.network(
                  product.fullImagenUrl,
                  width: 70,
                ),
                title: Text(product.nombre, maxLines: 1, overflow: TextOverflow.ellipsis,),
                trailing: Column(
                  children: [
                    Text(
                      'Bs. ${ (price * cantidad).toStringAsFixed(2) }',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                    const SizedBox(height: 3,),
                    Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              decrease(cartService, index);
                              //cartService.updateCartDetail(cartDetailId, cantidad, price);
                            },//decrease,
                            child: const Icon(Icons.remove, size: 20,),
                          ),
                          Text('$cantidad', style: const TextStyle(fontSize: 18),),
                          GestureDetector(
                            onTap: () {
                              increase(cartService, index);
                            },//increase,
                            child: const Icon(Icons.add, size: 20,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              ),
            );
          },
          separatorBuilder: ( _ , index) => const Divider(height: 0),
        ),
      bottomNavigationBar: 
      (cartDetails.isNotEmpty)  
        ? CartNavigationBar(total: total.toStringAsFixed(2),)
        : null        
    );
  }
}

