import 'package:everything_stash/models/db_model.dart';
import 'package:everything_stash/pages/item_list_page.dart';
import 'package:flutter/material.dart';

import '../models/stash.dart';

class StashCard extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback? refreshPage;

  const StashCard({this.title, this.description, this.refreshPage, Key? key})
      : super(key: key);

  void deleteStash(title) {
    var db = DatabaseConnector();
    db.findStash(title).then((Stash stash) {
      db.deleteStash(stash).then((value) {
        refreshPage!.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.storage_rounded, size: 38),
        title: Text(title.toString()),
        subtitle: Text(description.toString()),
        trailing: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              deleteStash(title);
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
        onTap: () {
          var db = DatabaseConnector();
          Stash? stash;
          db.findStash(title).then((Stash s) {
            stash = s;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (buildContext) => ItemListPage(
                  stash: stash,
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
