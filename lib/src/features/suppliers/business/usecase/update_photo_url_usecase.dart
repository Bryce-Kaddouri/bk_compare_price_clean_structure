import '../repository/supplier_repository.dart';

class UpdatePhotoUrlUseCase  {
  final SupplierRepository repository;

  UpdatePhotoUrlUseCase({required this.repository});

  Future<void> call(String supplierId, String url) async {
    return await repository.updatePhotoUrl(supplierId, url);
  }
}