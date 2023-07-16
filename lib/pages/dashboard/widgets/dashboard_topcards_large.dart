import 'package:e_shopweb/pages/dashboard/widgets/top_cards.dart';
import 'package:flutter/material.dart';

class DashBoardTopCardsLargeScreen extends StatelessWidget {
  const DashBoardTopCardsLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
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
          width: _width / 64,
        ),
        TopCards(
          title: "Total des ordres",
          subtitle: "3290",
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
          subtitle: "158",
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
  }
}
