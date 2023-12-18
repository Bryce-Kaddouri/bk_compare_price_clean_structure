import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository repository;

  GetAllProductsUseCase({required this.repository});

  Future<List<ProductModel>> call() async {
    return await repository.getAllProducts();
  }
}
