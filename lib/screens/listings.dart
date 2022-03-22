import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ListingsScreen extends StatelessWidget {
  static const id = '/listings';

  const ListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Listings"),
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
