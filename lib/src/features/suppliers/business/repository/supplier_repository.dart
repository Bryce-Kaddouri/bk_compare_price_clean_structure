import '../../data/model/supplier_model.dart';

abstract class SupplierRepository{
  Future<List<SupplierModel>> getAllSuppliers();
  Future<SupplierModel> getSupplierById(String id);
  Future<void> addSupplier(SupplierModel supplier);
  Future<void> updateSupplier(SupplierModel supplier);
  Future<void> deleteSupplier(String id);
}