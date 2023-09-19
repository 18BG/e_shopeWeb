import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/model/commande_model.dart';
import 'package:e_shopweb/model/data_model2.dart';
import 'package:e_shopweb/model/vente_model.dart';

import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataTable extends StatefulWidget {
  final List<String> statu;
  final List<DataModele2> myData;

  final List<bool> isOrderProcessed;
  const MyDataTable(
      {super.key,
      required this.myData,
      required this.statu,
      required this.isOrderProcessed});

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  Color myColor(String statu) {
    if (statu == "En attente") {
      return Colors.orange;
    } else if (statu == "Livré") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  bool isModifiable = true;

  final ScrollController _scrollController = ScrollController();
  late GlobalProvider provider;
  @override
  void initState() {
    // _scrollController = ScrollController();
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // isOrderProcessed = List.generate(widget.myData.length, (index) => false);
    // isOrderProcessed[1] = true;
    // isOrderProcessed[3] = true;
    print(widget.isOrderProcessed.length);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: DataTable(
        columnSpacing: 30,
        showBottomBorder: true,
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Nom',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'e-mail',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Montant',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Addresse de livraison',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Statut',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Actions',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: List.generate(
          widget.myData.length,
          (index) => DataRow(
            cells: <DataCell>[
              DataCell(Text("${widget.myData[index].id}")),
              DataCell(Text(widget.myData[index].name)),
              DataCell(Text(widget.myData[index].mail)),
              DataCell(Text("${widget.myData[index].montant}")),
              DataCell(Text(widget.myData[index].deliveryAddress)),
              DataCell(Text(widget.myData[index].date.toIso8601String())),
              DataCell(
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: myColor(widget.myData[index].status),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        widget.myData[index].status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                widget.isOrderProcessed[index]
                    ? Text("Déjà traité")
                    : Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              print("#" * 50);
                              print(widget.myData[index].panier!.length);
                              List<VenteModel> vente = [];
                              for (var panier in widget.myData[index].panier!) {
                                for (var produit in panier.produit) {
                                  VenteModel this_vente = VenteModel(
                                      dateVente: DateTime.now(),
                                      name: produit.nom,
                                      imageUrl: produit.image,
                                      description: produit.description,
                                      price: produit.prix);
                                  vente.add(this_vente);
                                }
                              }
                              await provider.updateOrders(
                                  widget.myData[index].id,
                                  widget.myData[index].cmdId,
                                  "Livré",
                                  vente);
                              updateCmd(index, "Livré");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: myColor("Livré"),
                            ),
                            child: Text("Livré"),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              await provider.updateOrders(
                                  widget.myData[index].id,
                                  widget.myData[index].cmdId,
                                  "Annulé",
                                  null);
                              updateCmd(index, "Annulé");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: myColor("Annulé"),
                            ),
                            child: Text("Annulé"),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateCmd(int index, String newStatus) async {
    setState(() {
      widget.myData[index].status = newStatus;
      widget.isOrderProcessed[index] =
          true; // Marquez la commande comme traitée
    });
    _updateUI();
  }

  void _updateUI() {
    // Forcer une mise à jour de l'interface en appelant `setState` sans effectuer de changement réel
    setState(() {});
  }
}
