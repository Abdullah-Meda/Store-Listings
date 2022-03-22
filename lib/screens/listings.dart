import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:store_listings/models/product.dart';
import 'package:store_listings/services/database_service.dart';

class ListingsScreen extends StatelessWidget {
  static const id = '/listings';

  const ListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Store Listings")),
      body: SingleChildScrollView(
        child: FutureBuilder<List<ProductModel>>(
          future: DatabaseService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> list = [];
              return list.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                      child: const Center(child: Text('No products to display!')),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10).copyWith(bottom: 30),
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Text(list[index].productName);
                      },
                    );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
