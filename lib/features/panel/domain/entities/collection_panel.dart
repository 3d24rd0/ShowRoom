import 'collection.dart';

class CollectionPanel {
  CollectionPanel({
    required this.leftCollection,
    required this.rightCollection,
  });

  final List<Collection> leftCollection;
  final List<Collection> rightCollection;
}
