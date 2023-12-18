import 'package:bk_compare_price_mvc/src/features/products/business/repository/product_repository.dart';


class ProductUpdatePhotoUrlUseCase  {
  final ProductRepository repository;

  ProductUpdatePhotoUrlUseCase({required this.repository});

  Future<void> call(String supplierId, String url) async {
    return await repository.updatePhotoUrl(supplierId, url);
  }
}