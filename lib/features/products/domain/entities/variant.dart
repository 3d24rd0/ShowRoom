import 'package:meta/meta.dart';

import 'measure.dart';

class Variant {
  Variant({
    @required this.img,
    @required this.id,
    @required this.example,
    @required this.name,
    @required this.measures,
  });

  final String? img;
  final String? id;
  final String? example;
  final String? name;
  final List<Measure>? measures;
}
