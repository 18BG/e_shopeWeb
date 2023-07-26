import 'package:e_shopweb/model/product_model.dart';

class CartItem {
  ProductModel product;
  int quantity;
  double price;

  CartItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}
