import 'package:flutter/material.dart';

import 'package:store_listings/models/product.dart';
import 'package:store_listings/utils/constants.dart';
import 'package:store_listings/widgets/custom_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 5),
              child: CustomImageWidget(url: product.productUrl),
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
    );
  }
}