import 'package:e_shopweb/pages/dashboard/widgets/top_cards.dart';
import 'package:flutter/material.dart';

class DashBoardTopCardsSmallScreen extends StatelessWidget {
  const DashBoardTopCardsSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(15),
      height: 400,
      child: Column(
        children: [
          TopCards(
            title: "Total des ventes",
            subtitle: "198,349,900 FCFA",
            value: "7",
            iconColor: Colors.orange,
            isActive: false,
            onTap: () {},
            icone: Icons.monetization_on,
          ),
          SizedBox(
            width: _width / 6,
            height: 20,
          ),
          TopCards(
            title: "Total des ordres",
            subtitle: "3290",
            value: "17",
            iconColor: Colors.green,
            isActive: false,
            onTap: () {},
            icone: Icons.shopping_cart,
          ),
          SizedBox(
            width: _width / 6,
            height: 20,
          ),
          TopCards(
            title: "Total des produits",
            value: "3",
            subtitle: "158",
            iconColor: Colors.redAccent,
            isActive: false,
            onTap: () {},
            icone: Icons.production_quantity_limits,
          ),
        ],
      ),
    );
  }
}
