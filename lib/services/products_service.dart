import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:epharm_movil/helpers/debouncer.dart';
import 'package:epharm_movil/models/models.dart';
import 'package:epharm_movil/services/api_config.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = ApiConfig.baseUrl;
  //final _storage = const FlutterSecureStorage();

  final ScrollController scrollController = ScrollController();

  List<Product> products = [];

  List<Product> cartProducts = [];

  int _currentPage = 0;
  String? _search;

  bool isLoading = false;
  bool connected = true;
  bool isRefreshing = false;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<String>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<String>> get suggestionStream => _suggestionStreamController.stream;  

  ProductsService() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        getProducts();        
      }
    });

    //print("Cargando productos");
    //getProducts();
  }

  Future getAllProducts() async {
    _currentPage = 0;
    products.clear();

    _currentPage++;
    
    final url = Uri.http(_baseUrl, '/api/productos');
    try {

      final resp = await http.get(url);//, headers: {'Authorization': 'Bearer $token'});
      connected = true;    
      //notifyListeners();
      
      final productsMap = Products.fromRawJson(resp.body);
      products = [ ...products, ...productsMap.data]; 

      if (productsMap.data.isEmpty){
        _currentPage--;
      }

      // client.close();

      return products;
      //Capturamos la excepcion Connection timed out
    } catch (e) {
      print(e);
      connected = false;
      _currentPage--;
      return [];
    }
  }


  Future getProducts() async {  //TODO: Renombrar quizas a loadProductsToScreen
    if (isLoading) {
      //print("Peticion rechazada");
      return;
    }
    
    isLoading = true;
    //print("Peticion aceptada");
    notifyListeners();

    _currentPage++;

    final url = Uri.http(_baseUrl, '/api/productos', {
      'page': '$_currentPage',
      'search': _search
    },);
    //TODO: Implementar Autenticacion para obtener el token
    //final token = await _storage.read(key: 'token') ?? '';
    
    try {
      // final client = HttpClient()
      // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      // final request = await client.getUrl(url);
      // final response = await request.close();

      final resp = await http.get(url);//, headers: {'Authorization': 'Bearer $token'});
      connected = true;    
      notifyListeners();

      // final responseBody = await response.transform(utf8.decoder).join();
      // final productsMap = Products.fromRawJson(responseBody);

      final productsMap = Products.fromRawJson(resp.body);
      products = [ ...products, ...productsMap.data]; 

      if (productsMap.data.isEmpty){
        _currentPage--;
      } else {
        notifyListeners();
      }
      // client.close();
    } catch (e) {
      connected = false;
      _currentPage--;
      //print(e);
      notifyListeners();
    } finally {
      isLoading = false;
      isRefreshing = false;
      notifyListeners();
    }
  }

  Future<void> onRefresh() async {
    isRefreshing = true;
    notifyListeners();
    _currentPage = 0;
    products.clear();
    getProducts();
  }

  Future getProductsBySearch(String search) async {
    _currentPage = 0;
    products.clear();
    _search = search;

    _currentPage++;
    final url = Uri.http(_baseUrl, '/api/productos', {
      'page': '$_currentPage',
      'search': _search
    },);

    try {
      // final client = HttpClient()
      // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      final resp = await http.get(url);//, headers: {'Authorization': 'Bearer $token'});
      // final request = await client.getUrl(url);
      // final response = await request.close();
      
      connected = true;    
      //notifyListeners();

      // final responseBody = await response.transform(utf8.decoder).join();
      // final productsMap = Products.fromRawJson(responseBody);
      final productsMap = Products.fromRawJson(resp.body);
      products = [ ...products, ...productsMap.data]; 

      if (productsMap.data.isEmpty){
        _currentPage--;
      }

      // client.close();

      return products;
      //Capturamos la excepcion Connection timed out
    } catch (e) {
      connected = false;
      _currentPage--;
      return [];
    }
  }

  Future<List<Product>> searchProducts(String query) async {  //TODO: Agregar try catch para capturar la excepcion Connection timed out
    final url = Uri.http(_baseUrl, '/api/productos', {
      'page': '$_currentPage',
      'search': query
    },);

    // final client = HttpClient()
    //   ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    // final request = await client.getUrl(url);
    // final response = await request.close();

    // final responseBody = await response.transform(utf8.decoder).join();
    // final products = Products.fromRawJson(responseBody);

    // client.close();
    final response = await http.get(url);
    //print(response.body);
    final products = Products.fromRawJson(response.body);

    return products.data;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = ''; 
    debouncer.onValue = (value) async { 
      //print('Tenemos valor a buscar: $value');
      
      final results = await searchProducts(value);
      final List<String> suggestionsList = [];
      for (Product product in results) {
        if (product.nombre.toLowerCase().contains(query.toLowerCase()) && !suggestionsList.contains(product.nombre)){
          suggestionsList.add(product.nombre);
        }
        if (product.categoria!.toLowerCase().contains(query.toLowerCase()) && !suggestionsList.contains(product.categoria)) 
        {
          suggestionsList.add(product.categoria!);
        } 
        if (product.laboratorio!.toLowerCase().contains(query.toLowerCase()) && !suggestionsList.contains(product.laboratorio)) 
        {
          suggestionsList.add(product.laboratorio!);
        }
      }
        _suggestionStreamController.add(suggestionsList);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), ( _ ) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301)).then(( _ ) { 
      timer.cancel();
    }); 
  }
}