import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:showroom/features/products/domain/entities/measure.dart';
import 'package:showroom/features/products/domain/entities/variant.dart';
import 'measure_model.dart';

class VariantModel extends Variant {
  VariantModel({
    @required String img,
    @required String name,
    @required List<Measure> measures,
  }) : super(
          img: img,
          name: name,
          measures: measures,
        );

  factory VariantModel.fromJson(String str) =>
      VariantModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VariantModel.fromMap(Map<String, dynamic> json) => VariantModel(
        img: json["img"] == null ? null : json["img"],
        name: json["name"] == null ? null : json["name"],
        measures: json["measures"] == null
            ? null
            : List<Measure>.from(
                json["measures"].map((x) => MeasureModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "img": img == null ? null : img,
        "name": name == null ? null : name,
        "measures": measures == null
            ? null
            : List<dynamic>.from(
                measures.map(
                  (x) => MeasureModel.fromMeasure(x).toMap(),
                ),
              ),
      };
}
