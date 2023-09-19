import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/image_model.dart';

class NewProductModel {
  String? id;
  String name;
  double price;
  String description;
  int qteStock;
  List<ImageModele>? image;
  String imageUrl;
  DateTime dateAjout;

  NewProductModel(
      {this.id,
      this.image,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl,
      required this.qteStock,
      required this.dateAjout});

  factory NewProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    final listProduitData = file!['Images'];
    List<ImageModele>? listImages;
    if (listProduitData != null) {
      listImages = List<ImageModele>.from(
          listProduitData.map((element) => ImageModele.fromSnapshot(element)));
    } else {
      listImages = [];
    }
    Timestamp date = file!["dateAjout"];
    DateTime thisDate = date.toDate();
    return NewProductModel(
        id: data.id,
        name: file["Nom"],
        price: file["Prix"],
        description: file["Description"],
        imageUrl: file["Image"],
        qteStock: file["qteStock"],
        dateAjout: thisDate,
        image: listImages);
  }
}
