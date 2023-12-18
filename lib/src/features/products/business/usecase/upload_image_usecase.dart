import 'dart:io';
import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/products/business/repository/product_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProductUploadImageUseCase {
  final ProductRepository repository;

  ProductUploadImageUseCase({required this.repository});

  UploadTask? call(File file,String supplierId, Uint8List? bytes) {
    return repository.uploadImage(file, supplierId,bytes );
  }
}