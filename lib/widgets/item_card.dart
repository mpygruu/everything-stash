import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final String? name;
  final String? shortDescription;
  final String? longDescription;
  final String? quantity;
  final String? stashId;
  final VoidCallback? refreshPage;

  const ItemCard(
      {this.name,
      this.shortDescription,
      this.longDescription,
      this.quantity,
      this.stashId,
      this.refreshPage,
      Key? key})
      : super(key: key);

  void deleteItem(title) {
    var db = DatabaseConnector();
    db.findItem(name).then((Item item) {
      db.deleteItem(item).then((value) {
        refreshPage!.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.work, size: 34),
        title: Text(name.toString()),
        subtitle: Text(shortDescription.toString()),
        isThreeLine: true,
        trailing: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              deleteItem(name);
            }
          },
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              child: Text("Delete"),
              value: 0,
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
