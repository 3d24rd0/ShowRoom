import 'dart:async' show Future;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/panel/data/models/collection_panel_model.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';
import 'package:showroom/features/products/data/models/product_model.dart';
import 'package:showroom/features/products/domain/entities/product.dart';

abstract class AssetsDatasource {
  Future<Either<Failure, List<Product>>> jsonProducst();
  Future<Either<Failure, CollectionPanel>> jsonPanel(String id);
}

class AssetsDatasourceImpl implements AssetsDatasource {
  final String productsPatch;
  final String panelPatch;

  AssetsDatasourceImpl({
    required this.productsPatch,
    required this.panelPatch,
  });

  @override
  Future<Either<Failure, List<Product>>> jsonProducst() async {
    final string = await rootBundle.loadString(productsPatch);

    final body = json.decode(string).map((x) {
      return ProductModel.fromMap(x);
    });
    List<ProductModel> listProducts = List<ProductModel>.from(body);

    return Right(listProducts);
  }

  @override
  jsonPanel(String id) async {
    final string = await rootBundle.loadString(
      panelPatch.replaceAll("{id}", id),
    );

    var panel = CollectionPanelModel.fromMap(json.decode(string));

    return Right(panel);
  }
}
