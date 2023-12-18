import 'package:bk_compare_price_mvc/src/features/products/data/model/price_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  final String id;
  final String name;
  final String photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PriceModel> prices;

  ProductModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.prices
  });

  factory ProductModel.fromDocument(DocumentSnapshot documentSnapshot){
    return ProductModel(
      id: documentSnapshot.id,
      name: documentSnapshot['name'],
      photoUrl: documentSnapshot['photoUrl'],
      createdAt: documentSnapshot['createdAt'].toDate(),
      updatedAt: documentSnapshot['updatedAt'].toDate(),
      prices: []
/*
      prices: documentSnapshot['prices'].map<PriceModel>((price) => PriceModel.fromDocumentSnapshot(price)).toList()
*/
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'prices': prices.map((price) => price.toMap()).toList()
    };
  }

  PriceModel? getLatestPrice(){
    if(prices.isEmpty){
      return null;
    }
    return prices.reduce((current, next) => current.updatedAt.isAfter(next.updatedAt) ? current : next);
  }

  // setter for prices
  set setPrices(List<PriceModel> prices){
    this.prices.addAll(prices);
  }
}