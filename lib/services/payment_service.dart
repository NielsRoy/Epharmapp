import 'dart:convert';

import 'package:epharm_movil/models/payment.dart';
import 'package:epharm_movil/services/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class PaymentService extends ChangeNotifier {
  final String _baseUrl = ApiConfig.baseUrl;

  Payment payment = Payment();
  final storage = const FlutterSecureStorage();

  dynamic createPaymentIntent() async {
    try {
      double total = payment.total * 100;
      final body = {
        'amount': total,
      };
      final url = Uri.http(_baseUrl, '/api/stripe/client-secret');
      final response = await http.post(
        url,
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
        }
      );
      return jsonDecode(response.body);
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void savePayment() async {
    final clienteId = await storage.read(key: 'cliente_id') ?? '';
    payment.clienteId = clienteId;
    print(payment.toJson());
    try {
      final body = payment.toJson();
      final url = Uri.http(_baseUrl, '/api/pedido');
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
        }
      );
      print(response.body);
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }


}