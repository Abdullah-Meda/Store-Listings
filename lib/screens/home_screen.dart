import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
            _btnController1.success();
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.pushNamed(context, ListingsScreen.id);
            _btnController1.reset();
          },
        ),
      ),
    );
  }
}
