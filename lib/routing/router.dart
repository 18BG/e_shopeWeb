import 'package:e_shopweb/pages/athentication/authentication.dart';
import 'package:e_shopweb/pages/categorie/categorie.dart';
import 'package:e_shopweb/pages/commande/commande_management.dart';
import 'package:e_shopweb/pages/dashboard/dashboard.dart';
import 'package:e_shopweb/pages/product/product_management.dart';
import 'package:e_shopweb/pages/product/product_management/add_product.dart';
import 'package:e_shopweb/pages/product/product_management/product_list.dart';
import 'package:e_shopweb/pages/product/stock_prix.dart';
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
    case AuthenticationPageRoute:
      return _getPageRoute(AuthenticationPage());
    case AddProductRoute:
      return _getPageRoute(AddProduct());
    case CategorieScreenRoute:
      return _getPageRoute(CategoryScreen());
    case ProductListRoute:
      return _getPageRoute(ProductList());
    case StockAndPrixScreenRoute:
      return _getPageRoute(StockAndPrix());
    default:
      return _getPageRoute(DashBoard());
  }
}

PageRoute _getPageRoute(Widget child) {
  //return FadePageRoute(page: child);
  return MaterialPageRoute(builder: (context) => child);
}
