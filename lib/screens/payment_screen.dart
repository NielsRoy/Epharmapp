import 'package:epharm_movil/models/payment.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:epharm_movil/ui/input_decorations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> makePayment(BuildContext context) async {
    final paymentService = Provider.of<PaymentService>(context, listen: false);

    try {
      final paymentIntentData = await paymentService.createPaymentIntent();

      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.light,
          customFlow: false,
          merchantDisplayName: 'Epharm Movil',
        ),
      )
          .then((value) {
        displayPaymentSheet(context);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void displayPaymentSheet(BuildContext context) async {
    final paymentService = Provider.of<PaymentService>(context, listen: false);

    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentService.savePayment();
        //destruimos el stack de navegacion
        Navigator.pushNamedAndRemoveUntil(context, 'paysuccess', (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pago exitoso'),
            duration: Duration(seconds: 2),
          ),
        );
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e.error.localizedMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PaymentService paymentService = Provider.of<PaymentService>(context, listen: false);
    Payment payment = paymentService.payment;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar Bs. ${payment.total}', style: const TextStyle(color: Colors.black)),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '72474541',
                    labelText: 'Teléfono',
                    prefixIcon: Icons.phone
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 30,),

                TextFormField(
                  controller: _addressController,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Av. Soberania Calle 11',
                    labelText: 'Dirección',
                    prefixIcon: Icons.directions
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
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
        child: TextButton(
          onPressed: () {
            
            if (_formKey.currentState?.validate() ?? false) {
              payment.telefono = _phoneController.text;
              payment.direccion = _addressController.text;
              
              makePayment(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor complete todos los campos'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppTheme.primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('Pagar Bs. ${payment.total}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
