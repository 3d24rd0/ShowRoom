import 'package:meta/meta.dart';

class Measure {
  Measure({
    @required this.ref,
    @required this.height,
    @required this.width,
    @required this.description,
    @required this.img,
  });

  final String ref;
  final double height;
  final double width;
  final String description;
  final String img;
}
