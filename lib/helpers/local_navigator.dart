import 'package:e_shopweb/constants/controllers.dart';
import 'package:e_shopweb/pages/product/product_management/add_product.dart';
import 'package:e_shopweb/routing/router.dart';
import 'package:e_shopweb/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navController.navKey,
      initialRoute: DashboardRoute,
      onGenerateRoute: generateRoute,
    );
