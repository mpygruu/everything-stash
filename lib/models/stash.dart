import 'package:image/image.dart';
import 'item.dart';

class Stash {
  int? id;
  String? title;
  String? description;
  Image? image;
  List<Item> items = List.empty();
}
