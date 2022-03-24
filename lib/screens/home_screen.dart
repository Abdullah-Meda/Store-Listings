import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:store_listings/utils/constants.dart';
import 'package:store_listings/screens/listings_screen.dart';
import 'package:store_listings/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        backgroundColor: kAppColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      body: Center(
        child: RoundedLoadingButton(
          failedIcon: Icons.error_outline,
          color: kAppColor,
          successColor: Colors.green,
          errorColor: Colors.red,
          child: const Text('Load Data!', style: TextStyle(color: Colors.white)),
          controller: _btnController,
          onPressed: () async {
            await readAndExportJson();
            _btnController.success();
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.pushNamed(context, ListingsScreen.id).then((value) => _btnController.reset());
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
      String jsonData =
          await DefaultAssetBundle.of(context).loadString("assets/data/products.json");
      await DatabaseService.setProducts(json.decode(jsonData) as List<dynamic>);
    } else {
      debugPrint("Data already present in db");
    }
  }
}
