import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TopOfComponents extends StatelessWidget {
  final int nb;
  final String type;
  final String action;
  const TopOfComponents(
      {super.key, required this.nb, required this.type, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          MyText(text: "$nb"),
          SizedBox(
            height: 10,
          ),
          MyText(text: type),
          SizedBox(
            height: 15,
          ),
          MyText(text: action),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
