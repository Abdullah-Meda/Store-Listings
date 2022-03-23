import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store_listings/models/product.dart';
import 'package:store_listings/services/database_service.dart';
import 'package:store_listings/widgets/custom_image.dart';

import '../utils/constants.dart';

class ListingsScreen extends StatefulWidget {
  static const id = '/listings';

  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 50,
                        color: colors[Random().nextInt(colors.length)],
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomImage(
                                    padding: EdgeInsets.only(right: 8, bottom: 5),
                                    side: 60,
                                    image: NetworkImage(
                                      "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.productName, style: kDarkLabelTextStyle),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                            "assets/ratings/${product.productRating}.png"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(product.productDescription, style: kLightLabelTextStyle)
                            ],
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return Image.asset(
              "assets/progress_indicators/loader.gif",
              width: MediaQuery.of(context).size.width,
            );
          }
        },
      ),
    );
  }
}
