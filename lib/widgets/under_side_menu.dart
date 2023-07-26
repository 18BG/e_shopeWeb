import 'package:e_shopweb/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../helpers/responsiveness.dart';
import '../routing/routes.dart';

class UnderSideMenus extends StatelessWidget {
  const UnderSideMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: sideMenuItems
          .map((item) => SideMenuItem(
                itemName: item.name,
                onTap: () {
                  if (item.route == AuthenticationPageRoute) {
                    menuControllere.changeActiveItemTo(DashboardDisplayName);
                    Get.offAllNamed(AuthenticationPageRoute);
                  }
                  if (!menuControllere.isActive(item.name)) {
                    menuControllere.changeActiveItemTo(item.name);
                    if (ResponsiveWidget.isSmallScreen(context)) {
                      Get.back();
                      //TODO:: go to item name Route
                    }
                    print(item.route);
                    navController.navTo(item.route);
                  }
                },
              ))
          .toList(),
    );
  }
}
