import 'dart:convert';

import 'package:showroom/features/panel/domain/entities/collection.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';

import 'collection_model.dart';

class CollectionPanelModel extends CollectionPanel {
  CollectionPanelModel({
    required List<Collection> leftCollection,
    required List<Collection> rightCollection,
  }) : super(
            leftCollection: leftCollection,
            rightCollection: rightCollection);

  factory CollectionPanelModel.fromJson(String str) =>
      CollectionPanelModel.fromMap(json.decode(str));

  factory CollectionPanelModel.fromMap(Map<String, dynamic> json) => CollectionPanelModel(
        leftCollection: json["leftCollection"] == null
            ? List.empty()
            : List<Collection>.from( json["leftCollection"].map((x) => CollectionModel.fromMap(x))),
        rightCollection: json["rightCollection"] == null
            ? List.empty()
            : List<Collection>.from(
                json["rightCollection"].map((x) => CollectionModel.fromMap(x))),
      );

}
