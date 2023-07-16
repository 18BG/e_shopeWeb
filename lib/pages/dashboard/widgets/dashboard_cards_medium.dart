import 'package:e_shopweb/pages/dashboard/widgets/top_cards.dart';
import 'package:flutter/material.dart';

class DashBoardCardsMediumScreenSize extends StatelessWidget {
  const DashBoardCardsMediumScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
          ],
        ),
        const SizedBox(
          width: 16,
          height: 15,
        ),
        Row(
          children: [
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
            Expanded(child: Container())
          ],
        )
      ],
    );
  }
}
