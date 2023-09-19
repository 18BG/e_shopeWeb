import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class VenteModel {
  String? id;
  String name;
  num price;
  String description;
  DateTime dateVente;

  String imageUrl;
  VenteModel(
      {required this.dateVente,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.price,
      this.id});

  factory VenteModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> data) {
    final donner = data.data();
    Timestamp date = donner!["dateVente"];
    DateTime thisDate = date.toDate();
    return VenteModel(
        id: data.id,
        name: donner['Nom'],
        imageUrl: donner["Image"],
        description: "Description",
        price: donner["Prix"],
        dateVente: thisDate);
  }
}
