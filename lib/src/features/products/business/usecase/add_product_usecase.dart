import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase({required this.repository});

  Future<String> call(ProductModel product) async {
    return await repository.addProduct(product);
  }
}