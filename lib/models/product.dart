import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String productUrl;
  @HiveField(1)
  final int productRating;
  @HiveField(2)
  final String productName;
  @HiveField(3)
  final String productDescription;

  Product({
    required this.productUrl,
    required this.productName,
    required this.productRating,
    required this.productDescription,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      productName: data['productName'],
      productUrl: data['productUrl'],
      productRating: data['productRating'],
      productDescription: data['productDescription'],
    );
  }
}
