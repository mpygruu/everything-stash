class Stash {
  int? id;
  String? title;
  String? description;

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
