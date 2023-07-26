import 'package:e_shopweb/constants/controllers.dart';

import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/model/categorie_model.dart';

import 'package:e_shopweb/pages/product/widgets/top_of_componenets.dart';
import 'package:e_shopweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_text.dart';
import 'components.dart';

class ComponentsCardsMedium extends StatefulWidget {
  const ComponentsCardsMedium({super.key});

  @override
  State<ComponentsCardsMedium> createState() => _ComponentsCardsMediumState();
}

class _ComponentsCardsMediumState extends State<ComponentsCardsMedium> {
  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        List<CategoryModel> listeCategory = value.categoryList;
        // List<ProductModel> produit = listeCategory.
        int nbproduit = 0;
        int nbCategorie = 0;
        for (var i in listeCategory) {
          nbCategorie++;
          int listpro = i.listProduct!.length;
          for (var r = 0; r <= listpro; r++) {
            nbproduit++;
          }
        }
        return (provider.isLoading)
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : (ResponsiveWidget.isSmallScreen(context))
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                TopOfComponents(
                                    nb: nbproduit,
                                    type: "Produits",
                                    action: "Voir tous les produits"),
                                const SizedBox(
                                  height: 10,
                                ),
                                TopOfComponents(
                                    nb: nbCategorie,
                                    type: "Catégorie",
                                    action: "Voir toutes les catégorie"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TopOfComponents(
                                    nb: 1,
                                    type: "Marque",
                                    action: "Voir les détails de la marque"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Components(
                                  onTap: () {
                                    navController.navTo(AddProductRoute);
                                  },
                                  content: "Ajouter un produit",
                                  textcolor: Colors.white,
                                  bckgColor: Colors.blue,
                                  icon: true,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Components(
                                  onTap: () {
                                    navController.navTo(ProductListRoute);
                                  },
                                  content: "Liste des produits",
                                  textcolor: Colors.blue,
                                  bckgColor: Colors.white,
                                  icon: false,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        height: 500,
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const MyText(
                                  text: "Vos derniers produits ajoutés",
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/vic17.jpeg",
                                        fit: BoxFit.contain,
                                        width: 250,
                                        height: 300,
                                      ),
                                      const MyText(
                                        text: "Casquette victoire",
                                        weight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          child: const MyText(
                                            text: "Publié",
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/stock.png",
                                  fit: BoxFit.contain,
                                  width: 70,
                                  height: 90,
                                ),
                                const MyText(text: "Stocks & Prix")
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Card(
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/marque.png",
                                  fit: BoxFit.contain,
                                  width: 70,
                                  height: 90,
                                ),
                                const MyText(text: "Marque")
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          navController.navTo(CategorieScreenRoute);
                        },
                        child: Container(
                          child: Card(
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/categorie.png",
                                    fit: BoxFit.contain,
                                    width: 70,
                                    height: 90,
                                  ),
                                  const MyText(text: "Catégorie")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    //Medium An large Screen part//////////////////////////
                    //Medium An large Screen part//////////////////////////
                    margin: const EdgeInsets.all(10),
                    height: 1000,
                    child: Column(
                      children: [
                        Card(
                          color: Colors.white,
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TopOfComponents(
                                        nb: nbproduit,
                                        type: "Produits",
                                        action: "Voir tous les produits"),
                                    TopOfComponents(
                                        nb: nbCategorie,
                                        type: "Catégorie",
                                        action: "Voir toutes les catégorie"),
                                    const TopOfComponents(
                                        nb: 1,
                                        type: "Marque",
                                        action:
                                            "Voir les détails de la marque"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Components(
                                      onTap: () {
                                        navController.navTo(AddProductRoute);
                                      },
                                      content: "Ajouter un produit",
                                      textcolor: Colors.white,
                                      bckgColor: Colors.blue,
                                      icon: true,
                                    ),
                                    SizedBox(
                                      width: _width / 60,
                                    ),
                                    Components(
                                      onTap: () {
                                        navController.navTo(ProductListRoute);
                                      },
                                      content: "Liste des produits",
                                      textcolor: Colors.blue,
                                      bckgColor: Colors.white,
                                      icon: false,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const MyText(
                                  text: "Vos derniers produits ajoutés",
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/vic17.jpeg",
                                        fit: BoxFit.contain,
                                        width: 250,
                                        height: 300,
                                      ),
                                      const MyText(
                                        text: "Casquette victoire",
                                        weight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          child: const MyText(
                                            text: "Publié",
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              height: 150,
                              child: Card(
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/stock.png",
                                        fit: BoxFit.contain,
                                        width: 70,
                                        height: 90,
                                      ),
                                      const MyText(text: "Stocks & Prix")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 300,
                              height: 150,
                              child: Card(
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/marque.png",
                                        fit: BoxFit.contain,
                                        width: 70,
                                        height: 90,
                                      ),
                                      const MyText(text: "Marque")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (ResponsiveWidget.isLargeScreen(context))
                              Container(
                                width: 300,
                                height: 150,
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/categorie.png",
                                          fit: BoxFit.contain,
                                          width: 70,
                                          height: 90,
                                        ),
                                        const MyText(text: "Catégorie")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (ResponsiveWidget.isMediumScreen(context))
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  navController.navTo(CategorieScreenRoute);
                                },
                                child: Container(
                                  width: 300,
                                  height: 150,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/categorie.png",
                                            fit: BoxFit.contain,
                                            width: 70,
                                            height: 90,
                                          ),
                                          const MyText(text: "Catégorie")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  );
      },
    );
  }
}
