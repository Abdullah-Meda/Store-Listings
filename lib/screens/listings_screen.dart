import 'dart:math';

import 'package:flutter/material.dart';

import 'package:store_listings/models/product.dart';
import 'package:store_listings/utils/constants.dart';
import 'package:store_listings/widgets/product_card.dart';
import 'package:store_listings/services/database_service.dart';

class ListingsScreen extends StatefulWidget {
  static const id = '/listings';

  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        backgroundColor: kAppColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      body: FutureBuilder<List<Product>>(
        future: DatabaseService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> list = snapshot.data!;
            return list.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                    child: const Center(child: Text('No products to display!')),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10).copyWith(bottom: 30),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = list[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 50,
                        color: colors[Random().nextInt(colors.length)],
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ProductCard(product: product),
                        ),
                      );
                    },
                  );
          } else {
            return Center(
              child: Image.asset(
                "assets/progress_indicators/loader.gif",
                width: MediaQuery.of(context).size.width,
              ),
            );
          }
        },
      ),
    );
  }
}
