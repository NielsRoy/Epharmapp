import 'dart:convert';

import 'package:epharm_movil/models/models.dart';

class CartDetail {
  int id;
  int carritoId;
  int productoId;
  int cantidad;
  String precio;
  DateTime createdAt;
  DateTime updatedAt;
  Product producto;

  CartDetail({
    required this.id,
    required this.carritoId,
    required this.productoId,
    required this.cantidad,
    required this.precio,
    required this.createdAt,
    required this.updatedAt,
    required this.producto,
  });

  factory CartDetail.fromRawJson(String str) => CartDetail.fromJson(json.decode(str));

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    id: json["id"],
    carritoId: json["carrito_id"],
    productoId: json["producto_id"],
    cantidad: json["cantidad"],
    precio: json["precio"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    producto: Product.fromJson(json["producto"]),
  );
}