import 'thickness.dart';

class Variant {
  Variant({
    this.img,
    this.id,
    this.example,
    this.name,
    this.thickness,
  });

  final String? img;
  final String? id;
  final String? example;
  final String? name;
  final List<Thickness>? thickness;
}
