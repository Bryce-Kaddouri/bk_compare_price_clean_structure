import 'package:bk_compare_price_mvc/src/features/products/data/model/price_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PriceModel> prices;

  ProductModel(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.createdAt,
      required this.updatedAt,
      required this.prices});

  factory ProductModel.fromDocument(DocumentSnapshot documentSnapshot) {
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'prices': prices.map((price) => price.toMap()).toList()
    };
  }

  List<PriceModel> getAllPricesOrderByDate(bool ascending) {
    /*// get all prices and sort them by date
    List<PriceModel> allPrices = [];
    for (PriceModel price in prices) {
      allPrices.add(price);
    }
    allPrices.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return allPrices;*/
    List<PriceModel> allPrices = [];
    for (PriceModel price in prices) {
      allPrices.add(price);
    }
    if (ascending) {
      allPrices.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else {
      allPrices.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
    return allPrices;
  }

  List<PriceModel> getLatestPrices() {
    // get the latest prices for each supplier
    List<PriceModel> latestPrices = [];
    List<String> suppliers = [];
    for (PriceModel price in prices) {
      if (!suppliers.contains(price.supplierId)) {
        suppliers.add(price.supplierId);
        latestPrices.add(price);
      }
    }
    return latestPrices;
  }

  // setter for prices
  set setPrices(List<PriceModel> prices) {
    this.prices.addAll(prices);
  }
}
