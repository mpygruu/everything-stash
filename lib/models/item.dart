class Item {
  int? id;
  String? name;
  String? shortDescription;
  String? longDescription;
  int? quantity;
  int? stashId;

  Item({
    this.id,
    this.name,
    this.shortDescription,
    this.longDescription,
    this.quantity,
    this.stashId,
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        shortDescription: json['shortDescription'],
        longDescription: json['longDescription'],
        quantity: json['quantity'],
        stashId: json['stashId'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'quantity': quantity,
      'stashId': stashId,
    };
  }
}
