import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String productUrl;
  final int productRating;
  final String productName;
  final String productDescription;

  ProductModel({
    required this.id,
    required this.productUrl,
    required this.productName,
    required this.productRating,
    required this.productDescription,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      id: doc.id,
      productName: doc['productName'],
      productUrl: doc['productUrl'],
      productRating: doc['productRating'],
      productDescription: doc['productDescription'],
    );
  }
}
