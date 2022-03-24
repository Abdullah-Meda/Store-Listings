import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:store_listings/utils/boxes.dart';
import 'package:store_listings/models/product.dart';

class DatabaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final _productsRef = _firestore.collection('products');

  static Future<List<Product>> getProducts() async {
    /// I used HiveDB, but is the following commented code what 4th point of question 2 of
    /// the challenge meant?
    // var snapshot = await productsRef.get(const GetOptions(source: Source.cache));
    // if (snapshot.docs.isEmpty) {
    //   snapshot = await productsRef.get(const GetOptions(source: Source.server));
    // }
    // debugPrint(snapshot.metadata.isFromCache ? "FROM CACHE" : "FROM FIRESTORE");

    await Hive.openBox<Product>("products"); // Open the box
    List<Product> products = [];
    if (Boxes.getProducts().length != 1000) {
      debugPrint("FROM FIRESTORE! >:(");
      await Boxes.getProducts().clear();
      for (Map<String, dynamic> map in (await _productsRef.get()).docs.first["data"]) {
        products.add(Product.fromJson(map));
        await Boxes.getProducts().add(Product.fromJson(map));
      }
    } else {
      debugPrint("FROM HIVE! :)");
      products = Boxes.getProducts().values.toList(); // And close it once done
    }
    Hive.close();
    return products;
  }

  static Future<void> setProducts(data) async {
    await FirebaseFirestore.instance.collection("products").doc("data").set({"data": data});
  }
}
