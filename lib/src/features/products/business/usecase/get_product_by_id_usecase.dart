import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase({required this.repository});

  Future<ProductModel> call(String id) async {
    return await repository.getProductById(id);
  }
}
