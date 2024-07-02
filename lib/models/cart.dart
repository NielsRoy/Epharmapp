import 'dart:convert';

import 'package:epharm_movil/models/models.dart';

class Cart {
  int id;
  int clienteId;
  String total;
  String estado;
  DateTime createdAt;
  DateTime updatedAt;
  List<CartDetail> cartDetails;

  Cart({
    required this.id,
    required this.clienteId,
    required this.total,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.cartDetails,
  });

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    clienteId: json["cliente_id"],
    total: json["total"],
    estado: json["estado"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    cartDetails: List<CartDetail>.from(json["detalle_carritoventa"].map((x) => CartDetail.fromJson(x))),
  );
}