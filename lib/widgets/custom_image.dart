import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String url;

  const CustomImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Image.network(
        url,
        fit: BoxFit.fill,
        // Error check: some images produced a 404 GET error
        errorBuilder: (_, __, ___) => Image.asset("assets/404.png", fit: BoxFit.fill),
      ),
    );
  }
}
