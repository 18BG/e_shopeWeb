import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String name;
  double price;
  String description;
  int qteStock;
  String imageUrl;

  ProductModel(
      {this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl,
      required this.qteStock});

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    return ProductModel(
        id: data.id,
        name: file!["Nom"],
        price: file["Prix"],
        description: file["Description"],
        imageUrl: file["Image"],
        qteStock: file["qteStock"]);
  }
}
