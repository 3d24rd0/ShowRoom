import 'package:meta/meta.dart';

import 'variant.dart';

class Product {
  Product({
    @required this.name,
    @required this.description,
    @required this.variants,
  });

  final String? name;
  final String? description;
  final List<Variant>? variants;
}
