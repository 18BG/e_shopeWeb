import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TachesModele {
  String titre;
  String contenue;
  String dateTache;
  String adminName;
  String adminLastName;
  String? profilImage;

  TachesModele({
    required this.titre,
    required this.adminName,
    required this.adminLastName,
    required this.contenue,
    required this.dateTache,
  });
  factory TachesModele.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    return TachesModele(
        titre: file!['titre'],
        adminName: file['adminName'],
        adminLastName: file['adminLastName'],
        contenue: file['contenue'],
        dateTache: file['dateTache']);
  }
}
