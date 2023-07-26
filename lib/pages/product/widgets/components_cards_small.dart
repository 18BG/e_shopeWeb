import 'package:e_shopweb/constants/style.dart';
import 'package:e_shopweb/pages/product/widgets/top_of_componenets.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/controllers.dart';
import '../../../routing/routes.dart';
import 'components.dart';

class ComponentsCardSmall extends StatelessWidget {
  const ComponentsCardSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  const TopOfComponents(
                      nb: 4,
                      type: "Produits",
                      action: "Voir tous les produits"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TopOfComponents(
                      nb: 4,
                      type: "Produits",
                      action: "Voir tous les produits"),
                  const SizedBox(
                    height: 10,
                  ),
                  const TopOfComponents(
                      nb: 4,
                      type: "Produits",
                      action: "Voir tous les produits"),
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
                      navController.navTo(AddProductRoute);
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
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
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
                            decoration: BoxDecoration(color: Colors.green),
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
        Container(
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
      ],
    );
  }
}
