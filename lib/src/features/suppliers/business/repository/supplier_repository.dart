import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../data/model/supplier_model.dart';

abstract class SupplierRepository{
  Future<List<SupplierModel>> getAllSuppliers();
  Future<SupplierModel?> getSupplierById(String id);
  Future<String?> addSupplier(SupplierModel supplier);
  Future<void> updateSupplier(SupplierModel supplier);
  Future<void> deleteSupplier(String id);
  UploadTask? uploadImage(File file,String supplierId, Uint8List? bytes);
  Future<void> updatePhotoUrl(String supplierId, String url);
}