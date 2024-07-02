import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! Nota Importante: En futuros proyectos usar una propia vista de search (con un provider), no la de flutter
//! Search Delegate
//! Ventajas: El build suggestions funciona sin un provider extra
//! Desventajas: No es muy personalizable, ej: el appBar de suggestions siempre sera el mismo que el de results 
//!la forma de llamarlo es distinta a la de un route
//! Se lo invoca con showSearch(context: context, delegate: ProductSearchDelegate());
class ProductSearchDelegate extends SearchDelegate{
  @override
  String? get searchFieldLabel => 'Buscar productos y marcas';

  @override
  ThemeData appBarTheme (BuildContext context) {
    return AppTheme.searchLightTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black,),
        onPressed: () {
          // final productsService = Provider.of<ProductsService>(context, listen: false);
          // productsService.getCartProducts();
          // Navigator.pushNamed(context, 'cart', arguments: productsService.cartProducts);
          Navigator.pushNamed(context, 'cart');
        }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'products');
        //Navigator.popUntil(context, ModalRoute.withName('home'));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context, listen: false);
    
    return FutureBuilder(
      future: productsService.getProductsBySearch(query),
      builder: ( _ , AsyncSnapshot snapshot) {
        if (snapshot.data == null){
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor,),
          );
        }

        return const ProductsMosaic();
      },
    );
  }

  Widget _emptyContainer() {
    return Container( //TODO: Revisar si es necesario el container
      child: const Center(
        child: Icon(Icons.medication_rounded, color: Colors.black38, size: 130,),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {//TODO: Verificar que no de errores cuando no haya internet o conexion con el server, de momento da un timed out error
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final productsService = Provider.of<ProductsService>(context, listen: false);
    productsService.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: productsService.suggestionStream,
      builder: ( _ , AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        
        final suggestions = snapshot.data!;

        return ListView.builder(
          itemCount: suggestions.length,
          //itemBuilder: (BuildContext context , int index) => _SuggestionItem(suggestions[index])
          itemBuilder: (BuildContext context , int index) {
            return ListTile(
              leading: const Icon(Icons.search_rounded, color: AppTheme.primaryColor,),
              title: Text(suggestions[index]),
              onTap: () {
                query = suggestions[index];
              },
            );
          }
        );
      },
    );
  }
}
