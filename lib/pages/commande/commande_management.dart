import 'dart:html';

import 'package:e_shopweb/constants/controllers.dart';
import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/achat_produit_model.dart';
import 'package:e_shopweb/model/commande_model.dart';
import 'package:e_shopweb/model/data_model2.dart';
import 'package:e_shopweb/model/panier_model.dart';
import 'package:e_shopweb/model/user_model.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:e_shopweb/widgets/orders_widget.dart';
import 'package:e_shopweb/widgets/rotating_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../model/data_row_model.dart';

class CommandeManagement extends StatefulWidget {
  const CommandeManagement({super.key});

  @override
  State<CommandeManagement> createState() => _CommandeManagementState();
}

class _CommandeManagementState extends State<CommandeManagement> {
  final List<DataModele> myData = [
    DataModele(
        id: 0,
        name: "Babry Galedou",
        mail: "bg@gmail.com",
        montant: 120430993,
        status: "Livré",
        deliveryAddress: "were",
        date: "12/07/2023"),
    DataModele(
        id: 43,
        name: "Aymane DEMBELE",
        mail: "aymane@gmail.com",
        deliveryAddress: "were",
        montant: 450,
        status: "En attente",
        date: "16/07/2023"),
    DataModele(
        id: 21,
        name: "Moussa",
        mail: "fma@gmail.com",
        deliveryAddress: "were",
        montant: 2700,
        status: "Annulé",
        date: "14/04/2023"),
    DataModele(
        id: 21,
        name: "Moussa",
        mail: "fma@gmail.com",
        deliveryAddress: "were",
        montant: 2700,
        status: "Annulé",
        date: "14/04/2023")
  ];
  late GlobalProvider provider;
  final bool isData = false;
  // Appeler getCategoryProvider dès le démarrage
  Future<void> _initializeData(BuildContext context) async {
    GlobalProvider provider =
        Provider.of<GlobalProvider>(context, listen: false);

    if (provider.categoryList.isEmpty) {
      await provider.fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeData(context),
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return RotatingWidget();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Une erreur s'est produite"),
            );
          } else {
            return Consumer<GlobalProvider>(builder: (context, data, child) {
              List<ClientModel> clientList = data.clientsList;
              List<CommandeModel> commande = [];
              List<String> statu = [];
              List<AchatProduitModel> produitCommande = [];
              List<PanierModel> panier = [];
              List<bool> isOrderProcessed = [];
              for (var i in clientList) {
                commande.addAll(i.commandes!);

                //print(commande.length);
              }
              for (var i in commande) {
                panier.addAll(i.produit);
                statu.add(i.etatCommande);
                if (i.etatCommande == "En attente") {
                  isOrderProcessed.add(false);
                } else {
                  isOrderProcessed.add(true);
                }
              }
              for (var i in panier) {
                produitCommande.addAll(i.produit);
              }
              List<DataModele2> dataModel = [];
              for (var i in clientList) {
                String id = i.firebaseToken!;
                String name = i.nom;
                String prnom = i.prenom;
                String mail = i.thismail;
                for (var index in i.commandes!) {
                  String adresse = index.adresseLivraison;
                  DateTime date = index.dateCommande;
                  num montant = index.prix;
                  String statu = index.etatCommande;
                  DataModele2 dataModele2 = DataModele2(
                      cmdId: index.firebaseToken!,
                      id: id,
                      name: name + " " + prnom,
                      mail: mail,
                      montant: montant,
                      status: statu,
                      date: date,
                      deliveryAddress: adresse);
                  dataModel.add(dataModele2);
                }
                print(dataModel.length);
                // print("taille ");
              }
              print(data.clientsList.length);
              //print("local");
              print(clientList.length);

              return Column(
                children: [
                  Obx(() => Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: ResponsiveWidget.isSmallScreen(context)
                                    ? 56
                                    : 6,
                                left: !ResponsiveWidget.isSmallScreen(context)
                                    ? 35
                                    : 0),
                            child: MyText(
                              text: menuControllere.activeItem.value,
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue)),
                            child: (commande.isNotEmpty)
                                ? MyDataTable(
                                    isOrderProcessed: isOrderProcessed,
                                    myData: dataModel,
                                    statu: statu,
                                  )
                                : const Center(
                                    child: MyText(text: "Aucune Commande"),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Colors.grey,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue)),
                            child: (clientList.isNotEmpty)
                                ? ListView.builder(
                                    itemCount: clientList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                MyText(
                                                    text:
                                                        "${clientList[i].nom}  ${clientList[i].prenom}")
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    })
                                : const Center(
                                    child: MyText(
                                        text:
                                            "Vos derniers clients s'afficheront ici"),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
          }
        });
  }
}
