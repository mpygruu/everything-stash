import 'package:flutter/material.dart';
import 'package:everything_stash/models/db_model.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../models/stash.dart';

class StashCard extends StatelessWidget {
  final String? title;
  final String? description;

  const StashCard({this.title, this.description, Key? key}) : super(key: key);

  void openStash() {}

  void deleteStash(Stash stash) {
    var db = DatabaseConnector();
    db.deleteStash(stash);
  }

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: () {
        //implement deleting a stash
      },
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(title: const Text('Open'), onPressed: () {}),
        FocusedMenuItem(title: const Text('Delete'), onPressed: () {})
      ],
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.storage_rounded, size: 38),
          title: Text(title.toString()),
          subtitle: Text(description.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
