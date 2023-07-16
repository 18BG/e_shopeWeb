import 'package:e_shopweb/widgets/vertical_menu.dart';
import 'package:flutter/material.dart';

import '../helpers/responsiveness.dart';
import 'horizontal_menu.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void Function()? onTap;
  const SideMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      print("VerticalMenuItem");
      return VerticalMenuItem(itemName: itemName, onTap: onTap);
    }
    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
