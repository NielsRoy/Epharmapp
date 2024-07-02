import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:epharm_movil/models/models.dart';
import 'package:epharm_movil/screens/screens.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/theme/app_theme.dart';
import 'package:epharm_movil/widgets/widgets.dart';

class ProductsMosaic extends StatelessWidget {

  const ProductsMosaic({
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context,);
    final List<Product> products = productsService.products;
    final size = MediaQuery.of(context).size;

    if (!productsService.connected){
      return FailedConnectionScreen(onRetry: productsService.getProducts);
    }

    if (!productsService.isRefreshing && products.isEmpty) {
      return const Center(
        child: Icon(
          Icons.search_off_rounded,
          size: 100,
          color: AppTheme.primaryColor,
        ),
      );
    }

    return Stack(
      children: [
        if (!productsService.isRefreshing)
          RefreshIndicator(
            color: AppTheme.primaryColor,
            onRefresh: productsService.onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: productsService.scrollController,
              itemCount: ((products.length - 1) ~/ 2) + 1,  //Tomamos de a 2 productos
              itemBuilder: ( _ , int index) => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 15),
                child: Row(
                  children: [
                    ProductCard(product: products[index * 2]),
                    const SizedBox(width: 15,),
                    if (products.length > index * 2 + 1)
                      ProductCard(product: products[index * 2 + 1],)
                    else
                      const Expanded(child: SizedBox())
                  ],
                )
              )
            )
          ),

        if (productsService.isLoading && !productsService.isRefreshing)
          Positioned(
            bottom: 40,
            left: size.width * 0.5 - 30,
            child: const _LoadingIcon()
          )
      ],
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: const CircularProgressIndicator(
        color: AppTheme.primaryColor,
        strokeWidth: 2,
      ),
    );
  }
}