import '../../data/model/price_model.dart';
import '../repository/product_repository.dart';

class UpdateProductPriceUseCase {
  final ProductRepository repository;

  UpdateProductPriceUseCase({required this.repository});

  Future<void> call(PriceModel price) async {
    return await repository.updateProductPrice(price);
  }
}