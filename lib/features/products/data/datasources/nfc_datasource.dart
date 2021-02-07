import 'dart:async' show Future;
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:showroom/core/domain/entities/failures.dart';

abstract class NfcDatasource {
  Future<Either<Failure, String>> readCard();
}

class NfcDatasourceExternalProgress implements NfcDatasource {
  @override
  Future<Either<Failure, String>> readCard() async {
    return Process.run('readNFC', List.empty()).then((result) {
      if (result.exitCode == 0) {
        return Right(result.stdout);
      } else {
        return Left(BadProgress());
      }
    });
  }
}
