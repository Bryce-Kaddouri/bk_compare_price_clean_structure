import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  UploadTask? uploadImageToStorage(File file) {
    try {
      final user = auth.currentUser;
      if (user != null) {
        return storage
            .ref('users/${user.uid}/suppliers/${file.path.split('/').last}')
            .putFile(file);
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }




}