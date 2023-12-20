import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupplierModel{
  final String id;
  final String name;
  final String photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Color color;

  SupplierModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
  });

  factory SupplierModel.fromDocument(DocumentSnapshot doc){
    return SupplierModel(
      id: doc.id,
      name: doc['name'],
      photoUrl: doc['photoUrl'],
      createdAt: doc['createdAt'].toDate(),
      updatedAt: doc['updatedAt'].toDate(),
      color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1),
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

SupplierModel copyWith({
    String? id,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    Color? color,
  }){
    return SupplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,

    );
  }

  @override
  String toString() {
    return 'SupplierModel(id: $id, name: $name, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}