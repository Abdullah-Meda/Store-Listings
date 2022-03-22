import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_listings/models/product.dart';

class DatabaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final productsRef = _firestore.collection('products');

  static Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = [];
    for (Map<String, dynamic> map in (await productsRef.get()).docs.first["data"]) {
      products.add(ProductModel.fromJson(map));
    }
    return products;
  }
}
