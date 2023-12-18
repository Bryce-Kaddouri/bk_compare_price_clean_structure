import 'package:cloud_firestore/cloud_firestore.dart';

class PriceModel{
  final String id;
  final String productId;
  final String supplierId;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime dateTime;

  PriceModel({
    required this.id,
    required this.productId,
    required this.supplierId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.dateTime

  });

  factory PriceModel.fromDocument(DocumentSnapshot documentSnapshot){
    Timestamp createdAt = documentSnapshot['createdAt'];
    Timestamp updatedAt = documentSnapshot['updatedAt'];
    Timestamp dateTime = documentSnapshot['dateTime'];
    return PriceModel(
      id: documentSnapshot.id,
      productId: documentSnapshot['productId'],
      supplierId: documentSnapshot['supplierId'],
      price: documentSnapshot['price'],
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      dateTime: dateTime.toDate()
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'productId': productId,
      'supplierId': supplierId,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'dateTime': dateTime
    };
  }

}