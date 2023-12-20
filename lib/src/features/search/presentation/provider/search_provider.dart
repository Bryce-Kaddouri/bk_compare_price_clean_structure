import 'package:flutter/material.dart';

import '../../../products/business/usecase/get_product_by_id_usecase.dart';
import '../../../products/data/model/price_model.dart';
import '../../../products/data/model/product_model.dart';

class SearchProvider with ChangeNotifier {
  final GetProductByIdUseCase getProductByIdUseCase;

  SearchProvider({required this.getProductByIdUseCase});

  SearchController _searchController = SearchController();

  SearchController get searchController => _searchController;

  void setSearchController(SearchController searchController) {
    _searchController = searchController;
    notifyListeners();
  }

  ProductModel? _selectedProduct;

  ProductModel? get selectedProduct => _selectedProduct;

  void getProductById(String productId) async {
    ProductModel? product = await getProductByIdUseCase.call(productId);
    if (product != null) {
      setSelectedProduct(product);
      List<PriceModel> prices = product.prices;
      for (PriceModel price in prices) {
        print('price: ${price.supplierId}');
      }
      // extract all suppliers
      List<String> suppliers = [];
      for (PriceModel price in prices) {
        if (!suppliers.contains(price.supplierId)) {
          suppliers.add(price.supplierId);
        }
      }
    }
  }

  double _barMaxPrice = 20;

  double get barMaxPrice => _barMaxPrice;

  set setMaxPrice(double maxPrice) {
    _barMaxPrice = maxPrice;
    notifyListeners();
  }

  double _barInterval = 10;

  double get barInterval => _barInterval;

  set setBarInterval(double interval) {
    _barInterval = interval;
    notifyListeners();
  }

  double _lineMaxPrice = 20;
  double get lineMaxPrice => _lineMaxPrice;
  set setLineMaxPrice(double maxPrice) {
    _lineMaxPrice = maxPrice;
    notifyListeners();
  }

  double _lineInterval = 10;
  double get lineInterval => _lineInterval;
  set setLineInterval(double interval) {
    _lineInterval = interval;
    notifyListeners();
  }

  List<String> _suppliers = [];
  List<String> get suppliers => _suppliers;
  set setSuppliers(List<String> suppliers) {
    _suppliers = suppliers;
    notifyListeners();
  }



  void setSelectedProduct(ProductModel product) {
    List<PriceModel> barPrices = product.getLatestPrices();
    List<PriceModel> linePrices = product.prices;
    List<String> suppliers = [];




    print('prices: ${barPrices.length}');
    double barMaxPrice = 20;
    double lineMaxPrice = 20;

    for (PriceModel price in linePrices) {
      if(suppliers.isEmpty) {
        suppliers.add(price.supplierId);
      } else {
        if(!suppliers.contains(price.supplierId)) {
          suppliers.add(price.supplierId);
        }
      }
      if (price.price > lineMaxPrice) {
        lineMaxPrice = price.price;
      }
    }
    _suppliers = suppliers;
    // arround up to the nearest 10
    lineMaxPrice = ((lineMaxPrice / 10).ceil() * 10).toDouble();
    print('maxPrice: $lineMaxPrice');

    for (PriceModel price in barPrices) {
      if (price.price > barMaxPrice) {
        barMaxPrice = price.price;
      }
    }
    // arround up to the nearest 10
    barMaxPrice = ((barMaxPrice / 10).ceil() * 10).toDouble();
    print('maxPrice: $barMaxPrice');
    _lineMaxPrice = lineMaxPrice;
    _lineInterval = lineMaxPrice / 5;
    _barMaxPrice = barMaxPrice;
    _barInterval = barMaxPrice / 5;
    _selectedProduct = product;
    notifyListeners();
  }
}
