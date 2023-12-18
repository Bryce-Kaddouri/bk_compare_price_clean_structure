import 'package:bk_compare_price_mvc/src/features/products/data/model/price_model.dart';

import '../repository/product_repository.dart';

class AddProductPriceUseCase  {
  final ProductRepository repository;

  AddProductPriceUseCase({required this.repository});

  Future<void> call(PriceModel price) async {
    return await repository.addProductPrice(price);
  }
}