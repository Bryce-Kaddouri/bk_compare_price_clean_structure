import '../../data/model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class AddSupplierUseCase {
  final SupplierRepository repository;

  AddSupplierUseCase({required this.repository});

  Future<String?> call(SupplierModel supplier) async {
    return await repository.addSupplier(supplier);
  }
}