import 'package:cloud_firestore/cloud_firestore.dart';

class PriceModel{
  final String id;
  final String productId;
  final String supplierId;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  PriceModel({
    required this.id,
    required this.productId,
    required this.supplierId,
    required this.price,
    required this.createdAt,
    required this.updatedAt
  });

  factory PriceModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    Timestamp createdAt = documentSnapshot['createdAt'];
    Timestamp updatedAt = documentSnapshot['updatedAt'];
    return PriceModel(
      id: documentSnapshot.id,
      productId: documentSnapshot['productId'],
      supplierId: documentSnapshot['supplierId'],
      price: documentSnapshot['price'],
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate()
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'productId': productId,
      'supplierId': supplierId,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

}