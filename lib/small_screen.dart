import 'package:e_shopweb/helpers/local_navigator.dart';

import 'package:flutter/material.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: localNavigator()),
      ],
    );
  }
}
