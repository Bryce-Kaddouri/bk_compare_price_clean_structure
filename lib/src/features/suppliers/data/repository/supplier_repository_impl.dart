import 'dart:io';
import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/suppliers/data/model/supplier_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../business/repository/supplier_repository.dart';
import '../datasource/supplier_datasource.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  final SupplierDataSource dataSource;

  SupplierRepositoryImpl({required this.dataSource});

  @override
  Future<String?> addSupplier(SupplierModel supplier) {
    return dataSource.addSupplierToFireStore(supplier);
  }

  @override
  Future<void> deleteSupplier(String id) {
    return dataSource.deleteSupplierFromFireStore(id);
  }

  @override
  Future<List<SupplierModel>> getAllSuppliers() {
    return dataSource.getSuppliersFromFireStore();
  }

  @override
  Future<SupplierModel?> getSupplierById(String id) {
    return dataSource.getSupplierByIdFromFireStore(id);
  }

  @override
  Future<void> updateSupplier(SupplierModel supplier) {
    return dataSource.updateSupplierToFireStore(supplier);
  }

  @override
  UploadTask? uploadImage(File file, String supplierId, Uint8List? bytes) {
    return dataSource.uploadImageToStorage(file, supplierId, bytes);
  }

  @override
  Future<void> updatePhotoUrl(String supplierId, String url) {
    return dataSource.updatePhotoUrl(supplierId, url);
  }


}