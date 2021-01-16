import 'dart:async' show Future;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:showroom/core/domain/entities/failures.dart';
import 'package:showroom/features/main/data/models/product_model.dart';

abstract class AssetsDatasource {
  Future<Either<Failure, List<ProductModel>>> jsonProducst();
}

class AssetsDatasourceImpl implements AssetsDatasource {
  final String productsPatch;

  AssetsDatasourceImpl({@required this.productsPatch});

  @override
  Future<Either<Failure, List<ProductModel>>> jsonProducst() async {
    final string = await rootBundle.loadString(productsPatch);

    final body = json.decode(string).map((x) {
      return ProductModel.fromMap(x);
    });
    List<ProductModel> listProducts = List<ProductModel>.from(body);

    return Right(listProducts);
  }
}
