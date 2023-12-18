import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase {

  final ProductRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<void> call(ProductModel product) async{
    await repository.updateProduct(product);
  }

}