import 'dart:convert';

import 'package:epharm_movil/services/api_config.dart';

class Product {
  final int id;
  final String nombre;
  final int stock;
  final String descripcion;
  final String precioventa;
  final DateTime fechaExp;
  final String? imagenUrl;
  final int idLaboratorio;
  final int idCategoria;
  final String? laboratorio;
  final String? categoria;
  final double precioDescuento;  

  int cantidad = 0;

  final String _baseUrl = 'http://${ApiConfig.baseUrl}';
  final String _defaultImgUrl = 'https://i.stack.imgur.com/GNhxO.png';

  Product({
      required this.id,
      required this.nombre,
      required this.stock,
      required this.descripcion,
      required this.precioventa,
      required this.fechaExp,
      this.imagenUrl,
      required this.idLaboratorio,
      required this.idCategoria,
      this.laboratorio,
      this.categoria,
      required this.precioDescuento,
  });

  get fullImagenUrl {
    if (imagenUrl != null) {
      return '$_baseUrl$imagenUrl';
    }
    return _defaultImgUrl;
  }

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      nombre: json["nombre"],
      stock: json["stock"],
      descripcion: json["descripcion"],
      precioventa: json["precioventa"],
      fechaExp: DateTime.parse(json["fecha_exp"]),
      imagenUrl: json["imagen_url"],
      idLaboratorio: json["id_laboratorio"],
      idCategoria: json["id_categoria"],
      laboratorio: json["laboratorio"],
      categoria: json["categoria"],
      precioDescuento: json["precio_descuento"].toDouble()
  );
}
