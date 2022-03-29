import 'package:everything_stash/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:everything_stash/models/db_model.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../models/stash.dart';

class StashCard extends StatelessWidget {
  final Stash? stash;

  const StashCard(this.stash, {Key? key}) : super(key: key);

  void openStash() {}

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: () {},
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(title: const Text('Open'), onPressed: () {}),
        FocusedMenuItem(
            title: const Text('Delete'),
            onPressed: () {
              var db = DatabaseConnector();
              db.deleteStash(stash);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const MainPage()));
            })
      ],
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.storage_rounded, size: 38),
          title: Text(stash!.title.toString()),
          subtitle: Text(stash!.description.toString()),
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
