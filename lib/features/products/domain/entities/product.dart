import 'variant.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.variants,
  });

  final String? id;
  final String? name;
  final String? description;
  final List<Variant>? variants;
}
