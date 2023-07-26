import 'package:flutter/material.dart';

import 'components.dart';

class ComponentsCardsLarge extends StatelessWidget {
  const ComponentsCardsLarge({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Components(
            onTap: () {},
            content: "Ajouter un produit",
            textcolor: Colors.blue,
            bckgColor: Colors.white,
            icon: true),
        SizedBox(
          width: _width / 60,
        ),
        Components(
          onTap: () {},
          content: "Modifier un produit",
          bckgColor: Colors.blueGrey,
          textcolor: Colors.white,
          icon: false,
        )
      ],
    );
  }
}
