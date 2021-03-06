import 'dart:async' show Future;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/futuristic/data/models/material_list_model%20copy.dart';
import 'package:showroom/features/futuristic/domain/entities/material_list.dart';
import 'package:showroom/features/panel/data/models/collection_panel_model.dart';
import 'package:showroom/features/panel/domain/entities/collection_panel.dart';
import 'package:showroom/features/products/data/models/product_model.dart';
import 'package:showroom/features/products/domain/entities/product.dart';

abstract class AssetsDatasource {
  Future<Either<Failure, List<Product>>> jsonProducst();
  Future<Either<Failure, CollectionPanel>> jsonPanel(String id);
  Future<Either<Failure, MaterialList>> jsonTv();
}

class AssetsDatasourceImpl implements AssetsDatasource {
  final String productsPatch;
  final String panelPatch;
  final String tvPatch;

  AssetsDatasourceImpl({
    required this.productsPatch,
    required this.panelPatch,
    required this.tvPatch,
  });

  @override
  Future<Either<Failure, List<Product>>> jsonProducst() async {
    final string = await rootBundle.loadString(productsPatch);

    final body = json.decode(string).map((x) {
      return ProductModel.fromMap(x);
    });
    List<Product> listProducts = List<Product>.from(body);

    return Right(listProducts);
  }

  @override
  jsonPanel(String id) async {
    final string = await rootBundle.loadString(
      panelPatch.replaceAll("{id}", id),
    );

    var panel = CollectionPanelModel.fromJson(string);

    return Right(panel);
  }

  @override
  jsonTv() async {
    final string = await rootBundle.loadString(
      tvPatch,
    );

    var tv = MaterialListModel.fromJson(string);

    return Right(tv);
  }
}
