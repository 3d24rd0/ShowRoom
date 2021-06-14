import 'dart:convert';

import 'package:showroom/features/products/domain/entities/measure.dart';
import 'package:showroom/features/products/domain/entities/thickness.dart';

import 'measure_model.dart';

class ThicknessModel extends Thickness {
  ThicknessModel({
    String? name,
    List<Measure>? measures,
  }) : super(
          name: name,
          measures: measures,
        );

  factory ThicknessModel.fromJson(String str) =>
      ThicknessModel.fromMap(json.decode(str));

  factory ThicknessModel.fromMap(Map<String, dynamic> json) => ThicknessModel(
        name: json["name"] == null ? null : json["name"],
        measures: json["measures"] == null
            ? null
            : List<Measure>.from(
                json["measures"].map((x) => MeasureModel.fromMap(x))),
      );
}
