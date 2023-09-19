import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/model/achat_produit_model.dart';
import 'package:e_shopweb/model/admin_model.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/image_model.dart';
import 'package:e_shopweb/model/new_product_model.dart';
import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/model/vente_model.dart';

import '../constants/text_constant.dart';
import '../model/commande_model.dart';
import '../model/like_model.dart';
import '../model/panier_model.dart';
import '../model/user_model.dart';

class FirebaseManagement {
  final _db = FirebaseFirestore.instance;

  ///////Sign User in///////////
  Future<AdminModele?> login(String mailFromUser, String thpassword) async {
    try {
      final query = await _db
          .collection("admin_info")
          .where("adminMail", isEqualTo: mailFromUser)
          .where(password, isEqualTo: thpassword)
          .get();
      final admin = query.docs.map((e) => AdminModele.fromSnapshot(e)).first;
      return admin;
    } catch (e) {
      print(e);
      print("hjsdbchyc");
    }
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

  Future<DocumentReference<Map<String, dynamic>>?> insertProduct(
    ProductModel produit,
    String id,
  ) async {
    try {
      var reponse = await _db
          .collection(categoriCollection)
          .doc(id)
          .collection(productCollection)
          .add({
        "Nom": produit.name,
        "Description": produit.description,
        "Prix": produit.price,
        "Image": produit.imageUrl,
        "qteStock": produit.qteStock,
        "Like": false
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
      return reponse;
    } catch (e) {
      print('Erreur lors de l\'enregistrement des données : $e');
      return null;
    }
  }

  ///Ajout des images pour un produit///
  Future<void> addImages(
      String images, String categorieId, String prduitId) async {
    try {
      await _db
          .collection(categoriCollection)
          .doc(categorieId)
          .collection(productCollection)
          .doc(prduitId)
          .collection("Images")
          .add({"image": images});
    } catch (e) {
      print("My images");
      print(e);
    }
  }

  //funtion to get categories and products
  Future<List<CategoryModel>> getCategorieAndProduc() async {
    final data = await _db.collection(categoriCollection).get();
    final categories =
        data.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    try {
      for (var index in categories) {
        //get specifics categorie products list from firebase
        final products = await _db
            .collection(categoriCollection)
            .doc(index.id)
            .collection(productCollection)
            .get();

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
      await _db
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
    List<ClientModel> customers = [];
    try {
      final data = await _db.collection(customer).get();
      final clients =
          data.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
      customers = clients;
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

        //add likes list to client likes list
        final likesListe =
            likes.docs.map((e) => LikeModel.fromSnapshot(e)).toList();
        i.likes = likesListe;
        //add Commande list to client Commande list
        final commandeListe =
            commandes.docs.map((e) => CommandeModel.fromSnapshot(e)).toList();
        i.commandes = commandeListe;
        for (var com in commandeListe) {
          final panniers = await _db
              .collection("Client")
              .doc(i.firebaseToken)
              .collection("Commande")
              .doc(com.firebaseToken)
              .collection("Pannier")
              .get();

          //add Pannier list to client pannier list
          final pannierListe =
              panniers.docs.map((e) => PanierModel.fromSnapshot(e)).toList();
          i.panniers = pannierListe;
          com.produit = pannierListe;
          for (var pan in pannierListe) {
            final produitAcheter = await _db
                .collection("Client")
                .doc(i.firebaseToken)
                .collection("Commande")
                .doc(com.firebaseToken)
                .collection("Pannier")
                .doc(pan.firebaseToken)
                .collection("Produits")
                .get();
            //add Pannier list to client pannier list
            final produitslist = produitAcheter.docs
                .map((e) => AchatProduitModel.fromSnapshot(e))
                .toList();

            pan.produit = produitslist;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return customers;
  }

  Future updateCommande(String clientId, String id, String newState) async {
    try {
      await _db
          .collection(customer)
          .doc(clientId)
          .collection(cmdCOllection)
          .doc(id)
          .update({"Etat": newState});
    } catch (e) {
      print("Probleme lors de la mise a jour du comande ");
      print(e);
    }
  }

  Future<void> addVente(VenteModel venteModel) async {
    try {
      await _db.collection("Vente").add({
        "Nom": venteModel.name,
        "Description": venteModel.description,
        "Prix": venteModel.price,
        "Image": venteModel.imageUrl,
        "dateVente": venteModel.dateVente
      });
    } catch (e) {
      print(e);
      print("_________urur");
    }
  }

  Future<List<VenteModel>?> getVente() async {
    try {
      var result = await _db.collection("Vente").get();
      var ventes = result.docs.map((e) => VenteModel.fromSnapShot(e)).toList();
      return ventes;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
