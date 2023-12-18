import 'package:bk_compare_price_mvc/src/features/products/data/model/price_model.dart';

import '../repository/product_repository.dart';

class DeleteProductPriceUseCase {
  final ProductRepository repository;

  DeleteProductPriceUseCase({required this.repository});

  Future<void> call(PriceModel price) async {
    return await repository.deleteProductPrice(price);
  }
}