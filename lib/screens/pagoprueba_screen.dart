import 'package:epharm_movil/models/payment.dart';
import 'package:epharm_movil/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PagopruebaScreen extends StatefulWidget {
  const PagopruebaScreen({Key? key}) : super(key: key);

  @override
  State<PagopruebaScreen> createState() => _PagopruebaScreenState();
}

class _PagopruebaScreenState extends State<PagopruebaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String _cardHolderName = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _phoneNumber = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_formatCardNumber);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _formatCardNumber() {
    String text = _cardNumberController.text.replaceAll(' ', '');
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    _cardNumberController.value = TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número de Teléfono',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    if (value.length < 6) {
                      return 'El número de teléfono debe tener al menos 7 dígitos';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre del titular de la tarjeta',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cardHolderName = value ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Numero de la tarjeta',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    if (value.replaceAll(' ', '').length != 16) {
                      return 'La tarjeta debe tener 16 digitos';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Remove spaces before saving the card number
                    _cardNumber = value?.replaceAll(' ', '') ?? '';
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '(MM/YY)',
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expiryDate = value ?? '';
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value.length != 3) {
                            return 'CVV debe tener 3 digitos';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cvv = value ?? '';
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Payment')),
                      );
                      // Aquí puedes agregar la lógica para procesar el pago
                    }
                  },
                  child: Text('Pay'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
