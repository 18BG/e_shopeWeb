import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/user_model.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_shopweb/helpers/firebase_management.dart';

import 'package:e_shopweb/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GlobalProvider with ChangeNotifier {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool isLoading = false;
  String? address;
  Uint8List webImage = Uint8List(8);
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
  QuerySnapshot? resultat;
  FirebaseManagement firebase = FirebaseManagement();

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
    isProcessing();
    try {
      var result = await firebase.getCategorieAndProduc();
      categoryList = result;
    } catch (e) {}
    isProcessing();
    notifyListeners();
  }

  Future<void> getClients() async {
    isProcessing();
    try {
      var result = await firebase.getClients();
      client = result;
    } catch (e) {}
    isProcessing();
    notifyListeners();
  }

  Future<bool> insertProduct(ProductModel produit, String id) async {
    try {
      firebase.insertProduct(produit, id);
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

  void isProcessing() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);

        pickedImage = selected;
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        webImage = f;
        pickedImage = File('a');
      } else {
        print('No image has been picked');
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
}
