import 'package:e_shopweb/model/panier_model.dart';

class DataModele2 {
  String id;
  String cmdId;
  String name;
  String mail;
  num montant;
  String status;
  DateTime date;
  String deliveryAddress;
  List<PanierModel>? panier;
  DataModele2(
    this.panier, {
    required this.id,
    required this.cmdId,
    required this.name,
    required this.mail,
    required this.montant,
    required this.status,
    required this.date,
    required this.deliveryAddress,
  });
}
