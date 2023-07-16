import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function()? onTap;
  const HorizontalMenuItem(
      {super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuControllere.onHover(itemName)
            : menuControllere.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuControllere.isHovering(itemName)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuControllere.isHovering(itemName) ||
                      menuControllere.isActive(itemName),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: dark,
                  ),
                ),
                SizedBox(
                  width: _width / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuControllere.returnIconFor(itemName),
                ),
                if (!menuControllere.isActive(itemName))
                  Flexible(
                      child: MyText(
                    text: itemName,
                    color:
                        menuControllere.isHovering(itemName) ? dark : lightGrey,
                  ))
                else
                  Flexible(
                      child: MyText(
                          text: itemName,
                          size: 18,
                          color: dark,
                          weight: FontWeight.bold))
              ],
            ),
          )),
    );
  }
}
