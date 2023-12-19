import 'package:flutter/material.dart';

import '../../../products/business/usecase/get_product_by_id_usecase.dart';
import '../../../products/data/model/price_model.dart';
import '../../../products/data/model/product_model.dart';

class SearchProvider with ChangeNotifier {
  final GetProductByIdUseCase getProductByIdUseCase;

  SearchProvider({required this.getProductByIdUseCase});

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

  set setInterval(double interval) {
    _barInterval = interval;
    notifyListeners();
  }

  void setSelectedProduct(ProductModel product) {
    List<PriceModel> prices = product.getLatestPrices();
    print('prices: ${prices.length}');
    double maxPrice = 20;
    for (PriceModel price in prices) {
      if (price.price > maxPrice) {
        maxPrice = price.price;
      }
    }
    // arround up to the nearest 10
    maxPrice = ((maxPrice / 10).ceil() * 10).toDouble();
    print('maxPrice: $maxPrice');
    _barMaxPrice = maxPrice;
    _barInterval = maxPrice / 5;
    _selectedProduct = product;
    notifyListeners();
  }
}
