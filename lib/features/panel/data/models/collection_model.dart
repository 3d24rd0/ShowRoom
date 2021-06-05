import 'dart:convert';

import 'package:showroom/features/panel/domain/entities/collection.dart';

class CollectionModel extends Collection {
  CollectionModel({
    required String productId,
    required String variantName,
    required String name,
    required int maxLines,
  }) : super(
          productId: productId,
          variantName: variantName,
          name: name,
          maxLines: maxLines,
        );

  factory CollectionModel.fromJson(String str) =>
      CollectionModel.fromMap(json.decode(str));

  factory CollectionModel.fromMap(Map<String, dynamic> json) => CollectionModel(
        productId: json["productId"] == null ? null : json["productId"],
        name: json["name"] == null ? null : json["name"],
        variantName: json["variantName"] == null ? null : json["variantName"],
        maxLines: json["maxLines"] == null ? null : json["maxLines"],
      );
}
