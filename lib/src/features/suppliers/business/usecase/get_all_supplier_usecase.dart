import '../../data/model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class GetAllSupplierUseCase {
  final SupplierRepository repository;

  GetAllSupplierUseCase({required this.repository});

  @override
  Future<List<SupplierModel>> call() async {
    return await repository.getAllSuppliers();
  }
}