import 'package:flutter/material.dart';

import '../../../products/data/model/product_model.dart';

class SearchProvider with ChangeNotifier{
  SearchController _searchController = SearchController();
  SearchController get searchController => _searchController;
  set searchController(SearchController searchController){
    _searchController = searchController;
    notifyListeners();
  }

  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;
  set selectedProduct(ProductModel? selectedProduct){
    _selectedProduct = selectedProduct;
    notifyListeners();
  }


}