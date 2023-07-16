import 'package:e_shopweb/routing/routes.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:e_shopweb/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import '../helpers/responsiveness.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    const Flexible(
                        child: MyText(
                            text: "Dash",
                            size: 20,
                            color: active,
                            weight: FontWeight.bold)),
                    SizedBox(
                      width: _width / 48,
                    )
                  ],
                ),
              ],
            ),
          const SizedBox(
            height: 40,
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        print(item.name);
                        if (item.route == DashboardRoute) {
                          menuControllere
                              .changeActiveItemTo(DashboardDisplayName);
                          Get.offAllNamed(CommandeManagementRoute);
                        }
                        if (!menuControllere.isActive(item.name)) {
                          menuControllere.changeActiveItemTo(item.name);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                            //TODO:: go to item name Route
                          }
                          //navigationController.navigateTo(item.route);
                        }
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
