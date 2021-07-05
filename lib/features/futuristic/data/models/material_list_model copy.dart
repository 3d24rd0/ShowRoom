import 'dart:convert';

import 'package:showroom/features/futuristic/domain/entities/material_list.dart';
import 'package:showroom/features/futuristic/domain/entities/materials.dart';

import 'materials_model.dart';

class MaterialListModel extends MaterialList {
  MaterialListModel({
    required List<Materials>? materiales,
  }) : super(materiales: materiales);

  factory MaterialListModel.fromJson(String str) =>
      MaterialListModel.fromMap(json.decode(str));

  factory MaterialListModel.fromMap(Map<String, dynamic> json) =>
      MaterialListModel(
        materiales: json["materiales"] == null
            ? null
            : List<Materials>.from(
                json["materiales"].map(
                  (x) => MaterialModel.fromMap(x),
                ),
              ),
      );
}
