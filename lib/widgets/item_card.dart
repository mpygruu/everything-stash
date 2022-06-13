import 'package:everything_stash/pages/long_description_page.dart';
import 'package:everything_stash/pages/new_item_form.dart';
import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/item.dart';
import '../models/stash.dart';

class ItemCard extends StatelessWidget {
  final int? id;
  final String? name;
  final String? shortDescription;
  final String? longDescription;
  final String? quantity;
  final String? stashId;
  final VoidCallback? refreshPage;

  const ItemCard(
      {this.id,
      this.name,
      this.shortDescription,
      this.longDescription,
      this.quantity,
      this.stashId,
      this.refreshPage,
      Key? key})
      : super(key: key);

  void deleteItem(int? id) {
    var db = DatabaseConnector();
    db.deleteItem(id!).then((value) => refreshPage!.call());
  }

  void changeQuantity(int? id, int? q) {
    var db = DatabaseConnector();
    db.changeQuantity(id, q).then((value) => refreshPage!.call());
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
              var db = DatabaseConnector();
              db.getStashById(int.parse(stashId!)).then(
                (stash) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (buildContext) => NewItemForm(
                        stash: stash,
                        updateMode: true,
                        itemId: id,
                      ),
                    ),
                  );
                },
              );
            } else if (result == 1) {
              changeQuantity(id, 1);
            } else if (result == 2) {
              if (int.parse(quantity!) >= 2) {
                changeQuantity(id, -1);
              }
            } else if (result == 3) {
              deleteItem(id!);
            }
          },
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              child: Text("Update data"),
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
            const PopupMenuItem(
              child: Text("Delete"),
              value: 3,
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
