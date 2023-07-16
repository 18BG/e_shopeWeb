import 'package:e_shopweb/constants/style.dart';
import 'package:e_shopweb/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuControllere extends GetxController {
  static MenuControllere instance = Get.find();
  var activeItem = DashboardDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  //Wi

  Widget returnIconFor(String itemName) {
    //1
    if (itemName == DashboardDisplayName) {
      return _customIcon(Icons.dashboard, itemName);
    } //2
    else if (itemName == ProductManagementDisplayName) {
      return _customIcon(Icons.production_quantity_limits, itemName);
    } //3
    else if (itemName == CommandeManagementDisplayName) {
      return _customIcon(Icons.shop, itemName);
    } //4
    else {
      return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
