import 'package:e_shopweb/model/product_model.dart';

class DashboardData {
  int totalOrders;
  int newUsers;
  List<ProductModel> popularProducts;

  DashboardData({
    required this.totalOrders,
    required this.newUsers,
    required this.popularProducts,
  });
}
