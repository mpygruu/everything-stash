class Item {
  int? id;
  String? name;
  String? description;
  //Image? image;

  Item({this.id, this.name, this.description});

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
