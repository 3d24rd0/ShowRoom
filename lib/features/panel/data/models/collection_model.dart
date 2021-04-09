import 'dart:convert';

import 'package:showroom/features/panel/domain/entities/collection.dart';

class CollectionModel extends Collection {
  CollectionModel({
    required String variantName,
    required String name,
  }) : super(variantName: variantName, name: name);

  factory CollectionModel.fromJson(String str) =>
      CollectionModel.fromMap(json.decode(str));

  factory CollectionModel.fromMap(Map<String, dynamic> json) => CollectionModel(
        name: json["name"] == null ? null : json["name"],
        variantName: json["variantName"] == null ? null : json["variantName"],
      );
}
