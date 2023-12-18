import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../model/supplier_model.dart';

class SupplierDataSource{
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;


  SupplierDataSource({required this.firestore, required this.storage, required this.auth});

  Future<String?> addSupplierToFireStore(SupplierModel supplier) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        DocumentReference ref = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .add(supplier.toDocument());
        return ref.id;
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
    return null;
  }

  Future<void> updateSupplierToFireStore(SupplierModel supplier) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .doc(supplier.id)
            .update(supplier.toDocument());
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> deleteSupplierFromFireStore(String id) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .doc(id)
            .delete();
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<SupplierModel>> getSuppliersFromFireStore() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .get();
        return snapshot.docs
            .map((doc) => SupplierModel.fromDocument(doc))
            .toList();
      }
      return [];
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<SupplierModel?> getSupplierByIdFromFireStore(String id) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .doc(id)
            .get();
        return SupplierModel.fromDocument(snapshot);
      }
      return null;
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
              .ref('users/${user.uid}/suppliers/$supplierId.jpg')
              .putData(data!, metadata);
        }else{
          return storage
              .ref('users/${user.uid}/suppliers/$supplierId.jpg')
              .putFile(file!, metadata);
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updatePhotoUrl(String supplierId, String photoUrl) async{
    try {
      final user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('suppliers')
            .doc(supplierId)
            .update({'photoUrl': photoUrl});
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }




}