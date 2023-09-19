import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/model/categorie_model.dart';
import 'package:e_shopweb/model/commande_model.dart';
import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/model/user_model.dart';
import 'package:e_shopweb/model/vente_model.dart';
import 'package:e_shopweb/pages/dashboard/widgets/top_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardTopCardsLargeScreen extends StatefulWidget {
  const DashBoardTopCardsLargeScreen({super.key});

  @override
  State<DashBoardTopCardsLargeScreen> createState() =>
      _DashBoardTopCardsLargeScreenState();
}

class _DashBoardTopCardsLargeScreenState
    extends State<DashBoardTopCardsLargeScreen> {
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
        List<VenteModel> venteModel = value.venteModel;
        num totalVente = 0;
        int totalOrders = 0;
        int totalProduits = 0;
        for (var i in venteModel) {
          totalVente = totalVente + i.price;
        }
        List<ClientModel> clients = value.clientsList;
        List<CommandeModel> commandes = [];
        for (var com in clients) {
          if (com.commandes != null) {
            commandes.addAll(com.commandes!);
          }
        }
        for (var i in commandes) {
          totalOrders++;
        }
        print(totalOrders);
        List<CategoryModel> categories = value.categoryList;

        List<ProductModel> produits = [];
        for (var cat in categories) {
          if (cat.listProduct != null) {
            produits.addAll(cat.listProduct!);
          }
        }
        for (var i in produits) {
          totalProduits++;
        }
        print("Totals produits :  $totalProduits");
        return Row(
          children: [
            TopCards(
              title: "Total des ventes",
              subtitle: totalVente.toString(),
              value: "7",
              iconColor: Colors.orange,
              isActive: false,
              onTap: () {},
              icone: Icons.monetization_on,
            ),
            SizedBox(
              width: _width / 64,
            ),
            TopCards(
              title: "Total des ordres",
              subtitle: totalOrders.toString(),
              value: "17",
              iconColor: Colors.lightGreen,
              isActive: false,
              onTap: () {},
              icone: Icons.shopping_cart,
            ),
            SizedBox(
              width: _width / 64,
            ),
            TopCards(
              title: "Total des produits",
              value: "3",
              subtitle: totalProduits.toString(),
              iconColor: Colors.redAccent,
              isActive: false,
              onTap: () {},
              icone: Icons.production_quantity_limits,
            ),
            SizedBox(
              width: _width / 64,
            ),
          ],
        );
      },
    );
  }
}
