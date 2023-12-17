import 'package:bk_compare_price_mvc/src/features/suppliers/data/model/supplier_model.dart';

import '../../business/repository/supplier_repository.dart';
import '../datasource/supplier_datasource.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  final SupplierDataSource dataSource;

  SupplierRepositoryImpl({required this.dataSource});

  @override
  Future<void> addSupplier(SupplierModel supplier) {
    // TODO: implement addSupplier
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSupplier(String id) {
    // TODO: implement deleteSupplier
    throw UnimplementedError();
  }

  @override
  Future<List<SupplierModel>> getAllSuppliers() {
    // TODO: implement getAllSuppliers
    throw UnimplementedError();
  }

  @override
  Future<SupplierModel> getSupplierById(String id) {
    // TODO: implement getSupplierById
    throw UnimplementedError();
  }

  @override
  Future<void> updateSupplier(SupplierModel supplier) {
    // TODO: implement updateSupplier
    throw UnimplementedError();
  }


}