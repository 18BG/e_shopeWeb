import 'dart:io';
import 'package:e_shopweb/model/image_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/admin_model.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/new_product_model.dart';
import 'package:e_shopweb/model/user_model.dart';
import 'package:e_shopweb/model/vente_model.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_shopweb/helpers/firebase_management.dart';

import 'package:e_shopweb/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class GlobalProvider with ChangeNotifier {
  static GlobalProvider instance = Get.find();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool isLoading = false;
  String? address;
  Uint8List webImage = Uint8List(8);
  List<Uint8List> multiWebImages = [];
  String? username;
  File? pickedImage;
  String? email;
  double? size;
  List<CategoryModel> categoryList = [];
  List<ClientModel> client = [];
  String? image;
  String? password;
  String? creation;
  String? token;
  num today_income = 0;
  num last_week = 0;
  List<Map<String, dynamic>> salesSummary = [];
  num last_thirty = 0;
  num last_twelve = 0;
  List<VenteModel> venteModel = [];
  QuerySnapshot? resultat;
  RxBool isLoadingu = false.obs;
  List<ClientModel> clientsList = [];
  FirebaseManagement firebase = FirebaseManagement();

/////////////////////Admin Login ///////////////////

//provider for the connexion
  Future<AdminModele?> login(String mailFromUser, String passwor) async {
    // Effectuez vos opérations de connexion ici
    try {
      AdminModele? element = await firebase.login(mailFromUser, passwor);

      if (element != null) {
        if (element.adminMail == mailFromUser &&
            element.thispassword == passwor) {
          lastName = element.nom;
          firstName = element.prenom;
          phoneNumber = element.telephone;
          address = element.addresse;
          username = element.adminUsername;
          email = element.adminMail;

          creation = element.thiscreationDate;
          image = element.image;
          password = element.thispassword;
          token = element.firebaseToken;
          print(token);

          notifyListeners();
        }
      }
      return element;
    } catch (e) {
      print(e);
      return null;
    }

    // Une fois la connexion réussie, mettez à jour les informations de l'utilisateur
  }

  Future<void> addCategorieProvider(CategoryModel categoryModel) async {
    try {
      await firebase.addCategorie(categoryModel);
      await getCategoryProvider();

      notifyListeners();
    } catch (e) {
      print("Erreur  ...  $e");
    }
  }

  Future<void> getCategoryProvider() async {
    try {
      print(isLoading);
      var result = await firebase.getCategorieAndProduc();
      categoryList = result;
      List<NewProductModel> newProduit;
      List<NewProductModel> newProduits = [];
      for (var i in categoryList) {
        newProduit = i.listNewProduct!;
        for (var index in newProduit) {
          // print(index.dateAjout.toIso8601String());
          // Obtenez la date et l'heure actuelles
          DateTime dateActuelle = DateTime.now();
          // Calculez la différence entre la date actuelle et la date d'ajout du produit
          Duration difference = dateActuelle.difference(index.dateAjout);
          //print(difference.inMinutes);

          // Vérifiez si la différence est supérieure à 48 heures (2 jours)
          if (difference.inDays > 7) {
            // print("Supprimer");
            deleteFromNewProduct(i.id!, index.id!);
          } else {
            newProduits.add(index);
            //print("ajouter");
          }
        }
      }
      // print(newProduits.length);
    } catch (e) {}
    isLoadingu.value = false;

    notifyListeners();
  }

/////////////*************Get all user and their properties***************/////////////////////
  Future<void> fetchUsers() async {
    try {
      var result = await firebase.getClients();
      clientsList = result;
    } catch (e) {
      var nothing = "";
      print(e);
    }
  }

////////////Update orders///////////////
  Future<void> updateOrders(String cleintId, String id, String newState,
      List<VenteModel>? vente) async {
    try {
      await firebase.updateCommande(cleintId, id, newState);
      print("Updated");
      if (newState == "Livré" && vente != null) {
        for (var vendu in vente) {
          await firebase.addVente(vendu);
          print("@----------Produit Vendu");
        }
      }
      print("object");
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchVente() async {
    try {
      var myVente = await firebase.getVente();
      if (myVente != null) {
        venteModel = myVente;
        await addAndSortSales(myVente);
        for (var index in myVente) {
          DateTime dateActuelle = DateTime.now();
          Duration dif = dateActuelle.difference(index.dateVente);
          //List<> week_summary = [];
          if (dif.inDays > 0 && dif.inDays < 2) {
            today_income += index.price;
            // week_summary.add(index.price);
          }
          if (dif.inDays > 7 && dif.inDays < 15) {
            last_week += index.price;
            String dayName = DateFormat('EEEE').format(index.dateVente);
            print(dayName);
          }
          if (dif.inDays > 30 && dif.inDays < 60) {
            last_thirty += index.price;
          }
          if (dif.inDays > 365) {
            last_twelve += index.price;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  ////////////Supprimer des produits de newProduits///////////////
  Future<void> deleteFromNewProduct(String idCategory, String idProduit) async {
    firebase.deleteFromNewProduct(idCategory, idProduit);
  }

  Future<void> getClients() async {
    await isProcessing();
    try {
      var result = await firebase.getClients();
      client = result;
    } catch (e) {
      print(e);
    }
    await isProcessing();
    notifyListeners();
  }

  Future<bool> insertProduct(
      ProductModel produit, String id, List<String> images) async {
    try {
      var reponse = await firebase.insertProduct(produit, id);
      if (reponse != null) {
        images.forEach((im) async {
          await firebase.addImages(im, id, reponse.id);
        });
      }

      return true;
    } catch (e) {
      print("Probleme provider $e");
      return false;
    }
  }

  // Pour utiliser Uint8List

  Future<String> uploadImageBytesToFirebase(Uint8List imageBytes) async {
    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Utilisez un nom de fichier unique pour chaque image pour éviter les collisions
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putData(imageBytes);
    TaskSnapshot taskSnapshot = await uploadTask;

    // Récupérer l'URL de téléchargement de l'image
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void getSize(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      size = 1040;
    } else {
      size = 1500;
    }
    notifyListeners();
  }

  Future<void> isProcessing() async {
    isLoading = !isLoading;
    notifyListeners();
  }

//get main image////
  Future<void> pickImage(bool isMulti) async {
    final ImagePicker _picker = ImagePicker();
    if (!kIsWeb) {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);

        pickedImage = selected;
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      if (!isMulti) {
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var f = await image.readAsBytes();

          webImage = f;
          pickedImage = File('a');
        } else {
          print('No image has been picked');
        }
      } else {
        final List<XFile>? pickedImage = await _picker.pickMultiImage();
        if (pickedImage != null) {
          pickedImage.forEach((e) async {
            var imageByte = await e.readAsBytes();
            multiWebImages.add(imageByte);
          });
          print(multiWebImages.length);
          print("Images recu");
        } else {
          debugPrint("No images has been selected");
        }
      }
    } else {
      print("Something went wrong");
    }
    notifyListeners();
  }

  void logout() {
    categoryList = [];
    webImage = Uint8List(8);
    pickedImage = null;
    notifyListeners();
  }

  Future<void> addAndSortSales(List<VenteModel> ventes) async {
    // Créez une Map pour regrouper les ventes par date au format "jour/mois/année"
    Map<String, List<num>> ventesParDate = {};

    // Parcourez les ventes et ajoutez-les à la Map
    for (VenteModel vente in ventes) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(vente.dateVente);
      if (ventesParDate.containsKey(formattedDate)) {
        ventesParDate[formattedDate]!.add(vente.price);
      } else {
        ventesParDate[formattedDate] = [vente.price];
      }
    }

    // Triez les dates dans l'ordre croissant
    List<String> datesTriees = ventesParDate.keys.toList()
      ..sort((a, b) => DateFormat('dd/MM/yyyy')
          .parse(a)
          .compareTo(DateFormat('dd/MM/yyyy').parse(b)));

    // Créez une liste finale des ventes triées
    List<Map<String, dynamic>> ventesTrie = [];
    for (String date in datesTriees) {
      num totalVentes = ventesParDate[date]!.reduce((a, b) => a + b);
      ventesTrie.add({
        'date': date,
        'totalVentes': totalVentes,
      });
    }
    salesSummary = ventesTrie;
    //print(ventesTrie[0]);
    print(salesSummary.length);
    int t = salesSummary.length;
    for (var i = 0; i < t; i++) {
      print("Element : ${salesSummary[i]}");
    }
    notifyListeners();
  }
}
