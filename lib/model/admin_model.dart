import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopweb/constants/text_constant.dart';
import 'package:e_shopweb/model/tache_model.dart';

class AdminModele {
  String nom;
  String prenom;
  String adminUsername;
  String? image;
  String adminMail;
  String addresse;
  String telephone;
  String thispassword;
  List<TachesModele>? adminTaches;
  String? firebaseToken;
  String thiscreationDate;

  AdminModele(
      {required this.nom,
      required this.prenom,
      required this.adminUsername,
      this.adminTaches,
      this.image,
      required this.addresse,
      required this.adminMail,
      required this.telephone,
      required this.thispassword,
      required this.thiscreationDate,
      this.firebaseToken});

  factory AdminModele.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    final listTachesData = file!['Taches'];
    List<TachesModele>? listTaches;
    if (listTachesData != null) {
      listTaches = List<TachesModele>.from(
          listTachesData.map((element) => TachesModele.fromSnapshot(data)));
    } else {
      listTaches = [];
    }
    Timestamp date = file[tacheDate];
    DateTime thisDate = date.toDate();
    return AdminModele(
        firebaseToken: data.id,
        nom: file[lastName],
        adminMail: file["adminMail"],
        addresse: file[address],
        prenom: file[firstName],
        adminUsername: file["adminUsername"],
        telephone: file[phone],
        thispassword: file[password],
        thiscreationDate: thisDate.toIso8601String(),
        image: file[profil],
        adminTaches: listTaches);
  }
}
