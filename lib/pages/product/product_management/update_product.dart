import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        const Center(
          child: MyText(
            text: "Modifier des produits",
            color: Colors.teal,
            size: 45,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
