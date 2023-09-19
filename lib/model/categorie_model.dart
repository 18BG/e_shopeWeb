import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/new_product_model.dart';
import 'package:e_shopweb/model/product_model.dart';

class CategoryModel {
  String? id;
  String name;
  String image;
  String description;
  List<ProductModel>? listProduct;
  List<NewProductModel>? listNewProduct;

  CategoryModel(
      {this.id,
      required this.name,
      required this.description,
      required this.image,
      this.listProduct,
      this.listNewProduct});

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    final listProduitData = file!['Produits'];
    final listNewProductData = file!['NewProduit'];
    List<ProductModel>? listProduit;
    List<NewProductModel>? listNewProduct;
    if (listProduitData != null) {
      listProduit = List<ProductModel>.from(
          listProduitData.map((element) => ProductModel.fromSnapshot(element)));
    } else {
      listProduit = [];
    }
    if (listNewProductData != null) {
      listNewProduct = List<NewProductModel>.from(listNewProductData
          .map((element) => NewProductModel.fromSnapshot(element)));
    } else {
      listNewProduct = [];
    }
    return CategoryModel(
        id: data.id,
        name: file["Nom"],
        description: file["Description"],
        image: file["Image"],
        listProduct: listProduit,
        listNewProduct: listNewProduct);
  }
}
