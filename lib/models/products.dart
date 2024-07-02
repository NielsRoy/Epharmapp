import 'dart:convert';

import 'package:epharm_movil/models/product.dart';

class Products {
    final int currentPage;
    final List<Product> data;
    final int lastPage;
    final String lastPageUrl;
    final int perPage;
    final int total;

    Products({
        required this.currentPage,
        required this.data,
        required this.lastPage,
        required this.lastPageUrl,
        required this.perPage,
        required this.total,
    });

    factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        currentPage: json["current_page"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        perPage: json["per_page"],
        total: json["total"],
    );
}