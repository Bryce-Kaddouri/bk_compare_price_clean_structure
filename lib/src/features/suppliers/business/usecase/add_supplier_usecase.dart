import '../../data/model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class AddSupplierUseCase {
  final SupplierRepository repository;

  AddSupplierUseCase({required this.repository});

  @override
  Future<void> call(SupplierModel supplier) async {
    return await repository.addSupplier(supplier);
  }
}