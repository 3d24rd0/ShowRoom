import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:showroom/features/products/domain/entities/thickness.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';

import 'thickness_model.dart';

class VariantModel extends Variant {
  VariantModel({
    @required String? img,
    @required String? example,
    @required String? id,
    @required String? name,
    @required List<Thickness>? thickness,
  }) : super(
          img: img,
          example: example,
          name: name,
          thickness: thickness,
          id: id,
        );

  factory VariantModel.fromJson(String str) =>
      VariantModel.fromMap(json.decode(str));

  factory VariantModel.fromMap(Map<String, dynamic> json) => VariantModel(
        img: json["img"] == null ? null : json["img"],
        id: json["id"] == null ? null : json["id"],
        example: json["example"] == null ? null : json["example"],
        name: json["name"] == null ? null : json["name"],
        thickness: json["thickness"] == null
            ? null
            : List<Thickness>.from(
                json["thickness"].map((x) => ThicknessModel.fromMap(x))),
      );
}
