import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:showroom/features/main/domain/entities/product.dart';
import 'package:showroom/features/main/domain/entities/variant.dart';

import 'variant_model.dart';

class ProductModel extends Product {
  ProductModel({
    @required String name,
    @required String description,
    @required List<Variant> variants,
  }) : super(description: description, name: name, variants: variants);

  factory ProductModel.fromJson(String str) {
    return ProductModel.fromMap(json.decode(str));
  }

  // String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"] == null ? null : json["name"],
      description: json["description"] == null ? null : json["description"],
      variants: json["variants"] == null
          ? null
          : List<Variant>.from(
              json["variants"].map((x) => VariantModel.fromMap(x))),
    );
  }

  // Map<String, dynamic> toMap() => {
  //       "name": name == null ? null : name,
  //       "description": description == null ? null : description,
  //       "variants": variants == null
  //           ? null
  //           : List<dynamic>.from(variants.map((x) => x.toMap())),
  //     };
}
