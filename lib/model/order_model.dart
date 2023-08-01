import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/model/user_model.dart';

class Order {
  int id;
  ClientModel user;
  List<ProductModel> products;
  DateTime orderDate;
  double totalAmount;

  Order({
    required this.id,
    required this.user,
    required this.products,
    required this.orderDate,
    required this.totalAmount,
  });
}
