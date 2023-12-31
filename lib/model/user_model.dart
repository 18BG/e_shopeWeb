import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/text_constant.dart';

class ClientModel {
  // "Prénom" -> "user4"
//"Nom d'utilisateur" -> "user4"
//"Mot de passe" -> "user4"
//"Date" -> "2023-06-17T23:04:04.574116"
//"Numéro de téléphone" -> "user4"
//"Image" -> ""
// "Nom" -> "user4"

// "user4" -> "user4"
  String nom;
  String prenom;
  String thisusername;
  String? image;
  String thismail;
  String addresse;
  String telephone;
  String thispassword;
  // List<LikeModel>? likes;
  // List<CommandeModel>? commandes;
  // List<PanierModel>? panniers;
  String? firebaseToken;
  String thiscreationDate;

  ClientModel(
      {required this.nom,
      required this.prenom,
      required this.thisusername,
      this.image,
      required this.addresse,
      required this.thismail,
      required this.telephone,
      required this.thispassword,
      required this.thiscreationDate,
      this.firebaseToken});

  factory ClientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    //to fetch client like liste
    // final listLikeData = file!['Like'];
    // List<LikeModel>? listLikes;
    // if (listLikeData != null) {
    //   listLikes = List<LikeModel>.from(
    //       listLikeData.map((element) => LikeModel.fromSnapshot(element)));
    // } else {
    //   listLikes = [];
    // }
    //to fetch client Commandes liste
    // final listCommandeData = file['Commande'];
    // List<CommandeModel>? listCommandes;
    // if (listCommandeData != null) {
    //   listCommandes = List<CommandeModel>.from(
    //       listCommandeData.map((element) => LikeModel.fromSnapshot(element)));
    // } else {
    //   listCommandes = [];
    // }
    //to fetch client panniers liste
    final listPannierData = file!['Pannier'];
    //List<PanierModel>? listPanniers;
    // if (listPannierData != null) {
    //   listPanniers = List<PanierModel>.from(
    //       listPannierData.map((element) => LikeModel.fromSnapshot(element)));
    // } else {
    //   listPanniers = [];
    // }
    return ClientModel(
        firebaseToken: data.id,
        nom: file![lastName],
        thismail: file[mail],
        addresse: file[address],
        prenom: file[firstName],
        thisusername: file[username],
        telephone: file[phone],
        thispassword: file[password],
        thiscreationDate: file[creationDate],
        image: file["Image"]);
  }
}
