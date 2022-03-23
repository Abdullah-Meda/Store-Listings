import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store_listings/models/product.dart';
import 'package:store_listings/services/database_service.dart';

import '../utils/constants.dart';

class ListingsScreen extends StatelessWidget {
  static const id = '/listings';

  const ListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        backgroundColor: kAppColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: DatabaseService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data!;
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
                      ProductModel product = list[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 50,
                        color: createRandomColor().withOpacity(0.3),
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(product.productName, style: kDarkLabelTextStyle),
                                  SizedBox(
                                    height: 20,
                                    child:
                                        Image.asset("assets/ratings/${product.productRating}.png"),
                                  )
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
            return Container();
          }
        },
      ),
    );
  }
}
