import 'dart:convert';
import 'package:epharm_movil/services/api_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AuthService extends ChangeNotifier {
  final String _baseUrl = ApiConfig.baseUrl;
  final String _apiKey = '';

  final storage = const FlutterSecureStorage();

  Future<String?> createUser(
    String name, 
    String email, 
    String password,
    String ci,
    String telefono,
    String direccion,
    String sexo
  ) async 
  {
    final Map<String, dynamic> authData = {
      'name': name,
      'email': email,
      'password': password,
      'ci': ci,
      'telefono': telefono,
      'direccion': direccion,
      'sexo': sexo
    };

    // final url = Uri.http(_baseUrl, '/api', {
    //   'key': _apiKey
    // });

    // final url = Uri.https(_baseUrl, '/api/register');
    final url = Uri.http(_baseUrl, '/api/register');

    // final client = HttpClient()
    //   ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    // final request = await client.postUrl(url);
    // request.headers.set('Content-Type', 'application/json');
    // request.write(json.encode(authData));

    // final response = await request.close();
    // final responseBody = await response.transform(utf8.decoder).join();
    // final decodedResp = json.decode(responseBody);

    // client.close();
    final resp = await http.post(url, body: json.encode(authData), headers: {'Content-Type': 'application/json'});
    //print(resp.body);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('accessToken')) {
      
      await storage.write(key: 'token', value: decodedResp['accessToken']);
      //?Nota: Flutter Secure Storage solo acepta String
      await storage.write(key: 'cliente_id', value: '${decodedResp['cliente_id']}');

      return null;
    } else {
      return "error al crear usuario";
      //return decodedResp['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/api/login');
    // final url = Uri.https(_baseUrl, '/api/login');
    
    try {
      // final client = HttpClient()
      // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      // final request = await client.postUrl(url);
      // request.headers.set('Content-Type', 'application/json');
      // request.write(json.encode(authData));

      // final response = await request.close();
      // final responseBody = await response.transform(utf8.decoder).join();
      // final decodedResp = json.decode(responseBody);

      // client.close();

      final resp = await http.post(url, body: json.encode(authData), headers: {'Content-Type': 'application/json'});
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (decodedResp.containsKey('accessToken')) {
        
        await storage.write(key: 'token', value: decodedResp['accessToken']);
        await storage.write(key: 'cliente_id', value: '${decodedResp['cliente_id']}');

        return null;
      } else {
        return decodedResp['message'];
      }
    } catch (e)
    {
      print(e);
      
    }
  }

  Future logout() async {
    final url = Uri.http(_baseUrl, '/api/logout');

//    final url = Uri.https(_baseUrl, '/api/logout');
    final token = await readToken(); 

    // final client = HttpClient()
    // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    // final request = await client.postUrl(url);
    // request.headers.set('Authorization', 'Bearer $token');
    // request.headers.set('Content-Type', 'application/json');

    // final response = await request.close();

    // await response.drain();
    // client.close();
    final resp = await http.post(url, headers: {'Authorization': 'Bearer ${token}', 'Content-Type': 'application/json'});
    
    await storage.delete(key: 'token');
    await storage.delete(key: 'cliente_id');
    
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readClienteId() async {
    return await storage.read(key: 'cliente_id') ?? '';
  }

  Future<bool> validateLogin() async {
    final url = Uri.http(_baseUrl, '/api/validate-token');
    // final url = Uri.https(_baseUrl, '/api/validate-token');
    final token = await readToken();

    if (token == '')
    {
      return false;
    }

    // final client = HttpClient()
    // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    

    // final request = await client.getUrl(url);
    // request.headers.set('Authorization', 'Bearer $token');
    // request.headers.set('Content-Type', 'application/json');

    // final response = await request.close();
    // final jsonResponse = await response.transform(utf8.decoder).join();
    // final bool responseValue = jsonDecode(jsonResponse)['response'];

    // client.close();
    final resp = await http.get(url, headers: {'Authorization': 'Bearer ${token}', 'Content-Type': 'application/json'});

    // if (resp.statusCode == 200) {}
      final jsonResponse = jsonDecode(resp.body);
      final bool responseValue = jsonResponse['response'];
    return responseValue;
  } 
}

