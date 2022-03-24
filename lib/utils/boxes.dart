import 'package:hive/hive.dart';

import 'package:store_listings/models/product.dart';

class Boxes {
  static Box<Product> getProducts() => Hive.box("products");
}
