import 'package:epharm_movil/models/payment.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartNavigationBar extends StatelessWidget {
  const CartNavigationBar({
    Key? key, 
    required this.total,
  }) : super(key: key);

  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total: ', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              Text('Bs. $total', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          TextButton(
            onPressed: () {
              PaymentService paymentService = Provider.of<PaymentService>(context, listen: false);
              paymentService.payment.total = double.parse(total);
              Navigator.pushNamed(context, 'pedido');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppTheme.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Generar pedido', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}