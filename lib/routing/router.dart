import 'package:e_shopweb/pages/commande/commande_management.dart';
import 'package:e_shopweb/pages/dashboard/dashboard.dart';
import 'package:e_shopweb/pages/product/product_management.dart';
import 'package:e_shopweb/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardRoute:
      return _getPageRoute(DashBoard());
    case ProductManagementRoute:
      return _getPageRoute(ProductManagement());
    case CommandeManagementRoute:
      return _getPageRoute(CommandeManagement());
    default:
      return _getPageRoute(DashBoard());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
