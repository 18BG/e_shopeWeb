import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/image_model.dart';

class ProductModel {
  String? id;
  String name;
  double price;
  String description;
  int qteStock;
  String imageUrl;
  List<ImageModele>? image;
  bool like;

  ProductModel({
    this.id,
    this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.qteStock,
    required this.like,
  });

  factory ProductModel.fromSnapshot(
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
    return ProductModel(
        id: data.id,
        name: file["Nom"],
        price: file["Prix"],
        description: file["Description"],
        imageUrl: file["Image"],
        qteStock: file["qteStock"],
        like: file['Like'],
        image: listImages);
  }
}
