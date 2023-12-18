import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../repository/supplier_repository.dart';

class UploadImageUseCase {
  final SupplierRepository repository;

  UploadImageUseCase({required this.repository});

  UploadTask? call(File file,String supplierId, Uint8List? bytes) {
    return repository.uploadImage(file, supplierId,bytes );
  }
}