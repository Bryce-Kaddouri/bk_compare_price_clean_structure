import '../../data/model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class UpdateSupplierUseCase {
  final SupplierRepository supplierRepository;

  UpdateSupplierUseCase({required this.supplierRepository});

  Future<void> call(SupplierModel supplier) async {
    return await supplierRepository.updateSupplier(supplier);
  }
}