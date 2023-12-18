import '../../data/model/supplier_model.dart';
import '../repository/supplier_repository.dart';

class GetSupplierByIdUseCase{
  final SupplierRepository repository;

  GetSupplierByIdUseCase({required this.repository});

  @override
  Future<SupplierModel?> call(String id) async {
    return await repository.getSupplierById(id);
  }
}