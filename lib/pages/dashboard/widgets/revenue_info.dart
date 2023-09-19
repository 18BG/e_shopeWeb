import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class RevenuInfo extends StatelessWidget {
  final String title;
  final String amount;
  const RevenuInfo({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "$title \n\n",
                  style: TextStyle(color: lightGrey, fontSize: 16)),
              TextSpan(
                  text: "$amount FCFA",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold))
            ])));
  }
}
