import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../models/product.dart';
import 'listings.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController1 = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Listings"),
      ),
      body: Center(
        child: RoundedLoadingButton(
          failedIcon: Icons.cottage,
          child: const Text('Load Data!', style: TextStyle(color: Colors.white)),
          controller: _btnController1,
          onPressed: () async {
            // String data = await DefaultAssetBundle.of(context).loadString("assets/products.json");
            // final jsonResult = jsonDecode(data);
            // await FirebaseFirestore.instance
            //     .collection("products")
            //     .doc("data")
            //     .set({"data": jsonResult});
            // print(jsonResult[0].runtimeType);
            await readAndExportJson();
            _btnController1.success();
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.pushNamed(context, ListingsScreen.id);
            _btnController1.reset();
          },
        ),
      ),
    );
  }

  Future<void> readAndExportJson() async {
    // Adding all the data to a single document took 3.5s
    // Adding each product to its own document took 330s

    // JSON file was 477 KB (less than 1 MB), so storing all the data in 1 document made much more sense

    if ((await FirebaseFirestore.instance.collection('products').get()).size != 1) {
      String jsonData = await DefaultAssetBundle.of(context).loadString("assets/products.json");
      final data = json.decode(jsonData) as List<dynamic>;
      // for (Map<String, dynamic> map in data) {
      //   await FirebaseFirestore.instance.collection("products").add(map);
      // }
      await FirebaseFirestore.instance.collection("products").doc().set({"data": data});
    } else {
      debugPrint("Data already present in db");
    }
  }
}
