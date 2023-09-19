import 'package:e_shopweb/model/product_model.dart';
import 'package:e_shopweb/model/user_model.dart';

class Review {
  int id;
  ClientModel user;
  ProductModel product;
  double rating;
  String comment;
  DateTime date;

  Review({
    required this.id,
    required this.user,
    required this.product,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
