import 'dart:io';
import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/products/data/model/price_model.dart';
import 'package:bk_compare_price_mvc/src/features/products/data/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../business/repository/product_repository.dart';
import '../datasource/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<String> addProduct(ProductModel product) {
    return dataSource.addProductToFireStore(product);
  }

  @override
  Future<void> deleteProduct(String id) {
    return dataSource.deleteProductFromFireStore(id);
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    return dataSource.getAllProducts();
  }

  @override
  Future<ProductModel> getProductById(String id) {
    return dataSource.getProductById(id);
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    return dataSource.updateProductToFireStore(product);
  }

  @override
  UploadTask? uploadImage(File file, String supplierId, Uint8List? bytes) {
    return dataSource.uploadImageToStorage(file, supplierId, bytes);
  }

  @override
  Future<void> updatePhotoUrl(String supplierId, String url) {
    return dataSource.updatePhotoUrl(supplierId, url);
  }

  @override
  Future<void> addProductPrice(PriceModel price) {
    return dataSource.addProductPrice(price);
  }

  @override
  Future<void> deleteProductPrice(PriceModel price) {
    return dataSource.deleteProductPrice(price);
  }

  @override
  Future<void> updateProductPrice(PriceModel price) {
    return dataSource.updateProductPrice(price);
  }

}
