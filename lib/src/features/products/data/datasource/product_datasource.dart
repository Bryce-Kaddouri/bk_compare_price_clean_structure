import 'dart:io';

import 'package:bk_compare_price_mvc/src/features/products/data/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ProductDataSource{
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;

  ProductDataSource({required this.firestore, required this.storage, required this.auth});

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .get();
        List<ProductModel> products = snapshot.docs
            .map((e) => ProductModel.fromDocument(e))
            .toList();
        return products;
      }
      return [];
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<ProductModel> getProductById (String id) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .doc(id)
            .get();
        return ProductModel.fromDocument(snapshot);
      }
      throw Exception('User is not logged in');
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String> addProductToFireStore(ProductModel product) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        Map<String, dynamic> data = product.toMap();
        data.remove('prices');
        DocumentReference docRef = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .add(data);
        return docRef.id;
      }
      throw Exception('User is not logged in');
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateProductToFireStore(ProductModel product) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .doc(product.id)
            .update(product.toMap());
      }else{
        throw Exception('User is not logged in');
      }

    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> deleteProductFromFireStore(String id) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .doc(id)
            .delete();
      }
      throw Exception('User is not logged in');
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  UploadTask? uploadImageToStorage(File? file, String supplierId, Uint8List? data) {
    print('uploadImageToStorage');
    try {
      final user = auth.currentUser;
      print('user: $user');
      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      if (user != null) {
        if(kIsWeb) {
          print('data: $data');

          return storage
              .ref('users/${user.uid}/products/$supplierId.jpg')
              .putData(data!, metadata);
        }else{
          return storage
              .ref('users/${user.uid}/products/$supplierId.jpg')
              .putFile(file!, metadata);
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updatePhotoUrl(String productId, String photoUrl) async{
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .doc(productId)
            .update({'photoUrl': photoUrl});
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}

