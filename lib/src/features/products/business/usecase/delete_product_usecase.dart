import '../repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<void> call(String productId) async{
    await repository.deleteProduct(productId);
  }

}