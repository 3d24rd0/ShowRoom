import 'dart:convert';

import 'package:showroom/features/futuristic/domain/entities/materials.dart';

class MaterialModel extends Materials {
  MaterialModel({
    required String? name,
    required List<String>? products,
  }) : super(name: name, products: products);

  factory MaterialModel.fromJson(String str) =>
      MaterialModel.fromMap(json.decode(str));

  factory MaterialModel.fromMap(Map<String, dynamic> json) => MaterialModel(
        name: json["name"] == null ? null : json["name"],
        products: json["products"] == null
            ? null
            : List<String>.from(json["products"].map((x) => x)),
      );
}
