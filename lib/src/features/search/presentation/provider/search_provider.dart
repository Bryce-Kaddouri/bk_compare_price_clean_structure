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

  void setSelectedProduct(ProductModel product) {
    _selectedProduct = product;
    notifyListeners();
  }
}
