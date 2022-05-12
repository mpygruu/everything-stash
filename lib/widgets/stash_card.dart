import 'package:everything_stash/models/db_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class StashCard extends StatelessWidget {
  final String? title;
  final String? description;

  const StashCard({this.title, this.description, Key? key}) : super(key: key);

  void deleteStash() {}

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
              //DatabaseConnector.database;
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
