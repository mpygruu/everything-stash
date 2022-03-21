//import 'package:image/image.dart';
//import 'item.dart';

class Stash {
  int? id;
  String? title;
  String? description;
  //Image? image;
  //List<Item> items = List.empty();

  Stash({this.id, this.title, this.description});

  factory Stash.fromMap(Map<String, dynamic> json) => Stash(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
