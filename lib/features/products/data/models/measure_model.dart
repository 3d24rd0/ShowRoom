import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:showroom/features/products/domain/entities/measure.dart';

class MeasureModel extends Measure {
  MeasureModel({
    @required String? ref,
    required double height,
    required double width,
    @required String? description,
    @required String? img,
  }) : super(
            ref: ref,
            height: height,
            width: width,
            description: description,
            img: img);

  factory MeasureModel.fromJson(String str) =>
      MeasureModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeasureModel.fromMap(Map<String, dynamic> json) => MeasureModel(
        ref: json["ref"] == null ? null : json["ref"],
        height: json["height"] == null ? null : json["height"].toDouble(),
        width: json["width"] == null ? null : json["width"].toDouble(),
        description: json["description"] == null ? null : json["description"],
        img: json["img"] == null ? null : json["img"],
      );

  Map<String, dynamic> toMap() => {
        "ref": ref == null ? null : ref,
        "height": height,
        "width": width,
        "description": description == null ? null : description,
        "img": img == null ? null : img,
      };

  factory MeasureModel.fromMeasure(Measure measure) => MeasureModel(
        description: measure.description,
        ref: measure.ref,
        height: measure.height,
        width: measure.height,
        img: measure.img,
      );
}
