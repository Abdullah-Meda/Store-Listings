import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_listings/models/product.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  static bool synced = false;
  static final _firestore = FirebaseFirestore.instance;
  static final productsRef = _firestore.collection('products');

  static Future<List<ProductModel>> getProducts() async {
    var x = await productsRef.get(const GetOptions(source: Source.cache));
    print(x.docs.first.metadata.isFromCache);

    List<ProductModel> products = [];
    for (Map<String, dynamic> map in x.docs.first["data"]) {
      products.add(ProductModel.fromJson(map));
    }
    // for (Map<String, dynamic> map in (await productsRef.doc("data").getSavy())["data"]) {
    //   products.add(ProductModel.fromJson(map));
    // }
    return products;
  }
}

// // https://github.com/furkansarihan/firestore_collection/blob/master/lib/firestore_document.dart
// extension FirestoreDocumentExtension on DocumentReference {
//   Future<DocumentSnapshot> getSavy() async {
//     try {
//       DocumentSnapshot ds = await get(const GetOptions(source: Source.cache));
//       if (ds == null) {
//         print("Network call!");
//         return get(const GetOptions(source: Source.server));
//       }
//       return ds;
//     } catch (_) {
//       print("Network call!");
//       return get(const GetOptions(source: Source.server));
//     }
//   }
// }
//
// // https://github.com/furkansarihan/firestore_collection/blob/master/lib/firestore_query.dart
// extension FirestoreQueryExtension on Query {
//   Future<QuerySnapshot> getSavy() async {
//     try {
//       QuerySnapshot qs = await get(const GetOptions(source: Source.cache));
//       if (qs.docs.isEmpty) {
//         print("Network call!");
//         return get(const GetOptions(source: Source.server));
//       }
//       return qs;
//     } catch (_) {
//       return get(const GetOptions(source: Source.server));
//     }
//   }
// }
// class TaskRepository extends BaseRepository {
//   String? status;
//   bool? synced;
//
//   TaskRepository() {
//     ref = db.collection('products');
//   }
//
//   Future<List<ProductModel>> fetchDocuments() async {
//     List<ProductModel> documents = [];
//     var data = (await ref!
//         .doc("data")
//         .get(GetOptions(source: synced == true ? Source.cache : Source.serverAndCache)))["data"];
//     for (Map<String, dynamic> map in data) {
//       documents.add(ProductModel.fromJson(map));
//     }
//
//     return documents;
//   }
// }
//
// class BaseRepository with ChangeNotifier {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   bool debug = true;
//   CollectionReference? ref;
//   DateTime now = DateTime.now();
//
//   BaseRepository() {
//     db.settings;
//   }
// }
