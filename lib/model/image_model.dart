import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModele {
  String? token;
  String image;
  ImageModele({required this.image, token});
  factory ImageModele.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> data) {
    final file = data.data();
    return ImageModele(
      token: data.id,
      image: file!["Images"],
    );
  }
}
