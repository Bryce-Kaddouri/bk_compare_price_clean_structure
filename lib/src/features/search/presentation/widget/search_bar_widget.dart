import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/model/product_model.dart';
import '../../../products/presentation/provider/product_provider.dart';
import '../provider/search_provider.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({Key? key}) : super(key: key);

  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: SearchAnchor.bar(
            searchController: searchController,
            isFullScreen: true,
            suggestionsBuilder: (context, searchController) {
              List<ProductModel> products =
                  context.read<ProductProvider>().products;
              List<ProductModel> filteredProducts = products
                  .where((element) => element.name
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                  .toList();

              if (filteredProducts.isEmpty) {
                return [
                  Center(
                    child: Text('No Product'),
                  )
                ];
              } else {
                return List.generate(filteredProducts.length, (index) {
                  return ListTile(
                      leading: Image.network(filteredProducts[index].photoUrl),
                      title: Text(filteredProducts[index].name),
                      onTap: () {
                        String productId = filteredProducts[index].id;
                        String productName = filteredProducts[index].name;

                        context
                            .read<SearchProvider>()
                            .getProductById(productId);
                        // close search bar
                        searchController.closeView(productName);
                      });
                });
              }
            }));
  }
}
