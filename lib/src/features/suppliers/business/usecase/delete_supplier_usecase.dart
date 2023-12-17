import '../repository/supplier_repository.dart';

class DeleteSupplierUseCase {
  final SupplierRepository supplierRepository;

  DeleteSupplierUseCase({required this.supplierRepository});

  Future<void> call(String id) async {
    return await supplierRepository.deleteSupplier(id);
  }
}