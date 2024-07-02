import 'dart:convert';

class Payment {
  String clienteId;
  String direccion;
  String telefono;
  String latitude;
  String longitude;
  double total;

  Payment({
    this.clienteId = '',
    this.direccion = '',
    this.telefono = '',
    this.latitude = '',
    this.longitude = '',
    this.total = 0,
  });

  String toJson() {
    Map<String, dynamic> map = {
      'cliente_id': clienteId,
      'direccion': direccion,
      'telefono': telefono,
      'latitud': latitude,
      'longitud': longitude,
      'total': total,
    };

    return json.encode(map);
  }
}