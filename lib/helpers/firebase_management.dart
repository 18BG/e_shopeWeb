import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/new_product_model.dart';
import 'package:e_shopweb/model/product_model.dart';

import '../constants/text_constant.dart';
import '../model/user_model.dart';

class FirebaseManagement {
  final _db = FirebaseFirestore.instance;
  Future<QuerySnapshot<Object?>> login(
      String thusername, String thpassword) async {
    QuerySnapshot query = await _db
        .collection("Admin")
        .where(username, isEqualTo: thusername)
        .where(password, isEqualTo: thpassword)
        .get();
    return query;
  }

  Future<void> addCategorie(CategoryModel categoryModel) async {
    try {
      _db.collection(categoriCollection).add({
        "Nom": categoryModel.name,
        "Description": categoryModel.description,
        "Image": categoryModel.image
      });
    } catch (e) {
      print('Erreur lors de l\'enregistrement des données : $e');
    }
  }

  Future<void> insertProduct(
    ProductModel produit,
    String id,
  ) async {
    try {
      await _db
          .collection(categoriCollection)
          .doc(id)
          .collection(productCollection)
          .add({
        "Nom": produit.name,
        "Description": produit.description,
        "Prix": produit.price,
        "Image": produit.imageUrl,
        "qteStock": produit.qteStock,
      });

      await _db
          .collection(categoriCollection)
          .doc(id)
          .collection(newProductCollection)
          .add({
        "Nom": produit.name,
        "Description": produit.description,
        "Prix": produit.price,
        "Image": produit.imageUrl,
        "qteStock": produit.qteStock,
        "dateAjout": DateTime.now()
      });
    } catch (e) {
      print('Erreur lors de l\'enregistrement des données : $e');
    }
  }

  //funtion to get categories and products
  Future<List<CategoryModel>> getCategorieAndProduc() async {
    final data = await _db.collection(categoriCollection).get();
    final categories =
        data.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    try {
      for (final index in categories) {
        //get specifics categorie products list from firebase
        final products = await _db
            .collection(categoriCollection)
            .doc(index.id)
            .collection(productCollection)
            .get();
        print(index.name);
        print(index.listProduct);
        final productList =
            products.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
        index.listProduct = productList;

        //////////**************************////////////
        final newProducts = await _db
            .collection(categoriCollection)
            .doc(index.id)
            .collection(newProductCollection)
            .get();
        final newProductList = newProducts.docs
            .map((e) => NewProductModel.fromSnapshot(e))
            .toList();

        index.listNewProduct = newProductList;
        //////////************* -- Get Data -- *************////////////
      }
    } catch (e) {
      print("Erreur : $e");
    }
    return categories;
  }

///////////****Supprimer des produits de la table newProduits apres 48h *****/
  Future<void> deleteFromNewProduct(String idCategory, String id) async {
    try {
      final dataDeleted = await _db
          .collection(categoriCollection)
          .doc(idCategory)
          .collection(newProductCollection)
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  //function to get All client
  Future<List<ClientModel>> getClients() async {
    final data = await _db.collection("Client").get();
    final clients = data.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
    for (final i in clients) {
      //get specifics client likes list from firebase
      final likes = await _db
          .collection("Client")
          .doc(i.firebaseToken)
          .collection("Like")
          .get();
      //get specifics client Commandes list from firebase
      final commandes = await _db
          .collection("Client")
          .doc(i.firebaseToken)
          .collection("Commande")
          .get();
      //get specifics client Panniers list from firebase
      final panniers = await _db
          .collection("Client")
          .doc(i.firebaseToken)
          .collection("Pannier")
          .get();
      //add likes list to client likes list
      // final likesListe =
      //     likes.docs.map((e) => LikeModel.fromSnapshot(e)).toList();
      // i.likes = likesListe;
      // //add Commande list to client Commande list
      // final commandeListe =
      //     commandes.docs.map((e) => CommandeModel.fromSnapshot(e)).toList();
      // i.commandes = commandeListe;
      // //add Pannier list to client pannier list
      // final pannierListe =
      //     panniers.docs.map((e) => PanierModel.fromSnapshot(e)).toList();
      // i.panniers = pannierListe;
    }
    return clients;
  }
}
