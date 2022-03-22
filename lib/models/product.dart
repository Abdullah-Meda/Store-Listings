import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productUrl;
  final int productRating;
  final String productName;
  final String productDescription;

  ProductModel({
    required this.productUrl,
    required this.productName,
    required this.productRating,
    required this.productDescription,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['productName'],
      productUrl: json['productUrl'],
      productRating: json['productRating'],
      productDescription: json['productDescription'],
    );
  }
}
