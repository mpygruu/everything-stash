import 'package:everything_stash/pages/long_description_page.dart';
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

  void changeQuantity(name, q) {
    var db = DatabaseConnector();
    db.changeQuantity(name, q).then((value) => refreshPage!.call());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.work, size: 34),
        title: Text(name.toString()),
        subtitle: Text('Quantity: $quantity \n${shortDescription.toString()}'),
        isThreeLine: true,
        trailing: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              deleteItem(name);
            } else if (result == 1) {
              changeQuantity(name, 1);
            } else if (result == 2) {
              if (int.parse(quantity!) >= 2) {
                changeQuantity(name, -1);
              }
            }
          },
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              child: Text("Delete"),
              value: 0,
            ),
            const PopupMenuItem(
              child: Text("Add 1"),
              value: 1,
            ),
            const PopupMenuItem(
              child: Text("Remove 1"),
              value: 2,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (buildContext) => LongDescriptionPage(
                  name: name, longDescription: longDescription),
            ),
          );
        },
      ),
    );
  }
}
