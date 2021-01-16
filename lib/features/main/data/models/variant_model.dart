import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:showroom/features/main/domain/entities/variant.dart';

class VariantModel extends Variant {
  VariantModel({
    @required String img,
    @required String id,
  }) : super(id: id, img: img);

  factory VariantModel.fromJson(String str) =>
      VariantModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariantModel.fromMap(Map<String, dynamic> json) => VariantModel(
        img: json["img"] == null ? null : json["img"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "img": img == null ? null : img,
        "id": id == null ? null : id,
      };
}
