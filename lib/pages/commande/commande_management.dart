import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CommandeManagement extends StatelessWidget {
  const CommandeManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        text: "Commande",
        size: 30,
        weight: FontWeight.bold,
      ),
    );
  }
}
