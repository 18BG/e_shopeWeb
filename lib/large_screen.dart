import 'package:e_shopweb/helpers/local_navigator.dart';

import 'package:e_shopweb/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SideMenu()),
        Expanded(flex: 5, child: localNavigator())
      ],
    );
  }
}
