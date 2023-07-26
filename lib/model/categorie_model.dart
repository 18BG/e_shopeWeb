import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/product_model.dart';

class CategoryModel {
  String? id;
  String name;
  String image;
  String description;
  List<ProductModel>? listProduct;

  CategoryModel(
      {this.id,
      required this.name,
      required this.description,
      required this.image,
      this.listProduct});

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    final listProduitData = file!['Produits'];
    List<ProductModel>? listProduit;
    if (listProduitData != null) {
      listProduit = List<ProductModel>.from(
          listProduitData.map((element) => ProductModel.fromSnapshot(element)));
    } else {
      listProduit = [];
    }
    return CategoryModel(
        id: data.id,
        name: file["Nom"],
        description: file["Description"],
        image: file["Image"],
        listProduct: listProduit);
  }
}
