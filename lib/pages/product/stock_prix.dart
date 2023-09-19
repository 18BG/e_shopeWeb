import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/widgets/custom_text.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../constants/controllers.dart';

class StockAndPrix extends StatefulWidget {
  const StockAndPrix({super.key});

  @override
  State<StockAndPrix> createState() => _StockAndPrixState();
}

class _StockAndPrixState extends State<StockAndPrix> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);

    //provider.getCategoryProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        List<ProductModel> prodcutList = [];

        int nombreTotal = 0;
        num prixTotal = 0;
        List<CategoryModel> categoryListe = value.categoryList;

        for (var index in categoryListe) {
          index.listProduct!.forEach((element) {
            nombreTotal += 1;
            prixTotal += element.price;
          });
          prodcutList.addAll(index.listProduct as Iterable<ProductModel>);
        }
        print(nombreTotal);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        navController.goBack();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.chevron_left),
                            MyText(text: "retour"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const MyText(text: "Stock & prix"),
                  ],
                ),
              ),

              //const SizedBox(height: 20), // Espacement entre le bouton et la liste
              (value.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (value.categoryList.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap:
                              true, // Pour empêcher la liste de prendre tout l'espace disponible
                          itemCount: categoryListe.length,
                          // Remplacez cela par le nombre total d'éléments que vous souhaitez afficher dans la liste.
                          itemBuilder: (BuildContext context, int index) {
                            int nbProduitPerCategorie = 0;
                            num prix = 0;
                            List<ProductModel> listProductForThisCategorie = [];
                            for (var i in categoryListe) {
                              if (categoryListe[index].name == i.name) {
                                nbProduitPerCategorie = i.listProduct!.length;
                                listProductForThisCategorie = i.listProduct!;
                                for (var i in listProductForThisCategorie) {
                                  prix += i.price;
                                }
                              }
                            }
                            return Card(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        Column(
                                          children: [
                                            MyText(
                                              text: "Catégorie ",
                                              size: (!ResponsiveWidget
                                                      .isSmallScreen(context))
                                                  ? 17
                                                  : 13,
                                              weight: FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            MyText(
                                                text:
                                                    categoryListe[index].name),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            MyText(
                                              text: "Nombre de produits ",
                                              size: (!ResponsiveWidget
                                                      .isSmallScreen(context))
                                                  ? 17
                                                  : 13,
                                              weight: FontWeight.w700,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            MyText(
                                                text: "$nbProduitPerCategorie"),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            MyText(
                                              text:
                                                  "Prix des produits de la catégorie",
                                              size: (!ResponsiveWidget
                                                      .isSmallScreen(context))
                                                  ? 17
                                                  : 13,
                                              weight: FontWeight.w700,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            MyText(text: "$prix"),
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1.5,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    (listProductForThisCategorie.isNotEmpty)
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                listProductForThisCategorie
                                                    .length,
                                            itemBuilder:
                                                (BuildContext context, i) {
                                              return Card(
                                                elevation: 10,
                                                color: Colors.teal,
                                                child: ListTile(
                                                  title: MyText(
                                                      text:
                                                          listProductForThisCategorie[
                                                                  i]
                                                              .name),
                                                  trailing: MyText(
                                                      text:
                                                          "${listProductForThisCategorie[i].price}"),
                                                ),
                                              );
                                            })
                                        : const Center(
                                            child: MyText(
                                              text: "Aucun produit ",
                                              color: Colors.black,
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: MyText(
                            text: "Aucune catégorie",
                            color: Colors.black,
                            size: 30,
                            weight: FontWeight.w600,
                          ),
                        ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    children: [
                      Spacer(),
                      const MyText(
                        text: "Prix total de tous les produits ",
                        size: 15,
                        weight: FontWeight.w600,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      MyText(text: "$prixTotal"),
                      Spacer(),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
              )
            ],
          ),
        );
      },
    );
  }
}
