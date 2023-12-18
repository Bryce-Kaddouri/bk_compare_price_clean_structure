import 'dart:io';

import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/products/data/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<String> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);

  UploadTask? uploadImage(File file,String supplierId, Uint8List? bytes);
  Future<void> updatePhotoUrl(String supplierId, String url);
}