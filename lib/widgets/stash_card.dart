import 'package:flutter/material.dart';

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
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
        onTap: () {},
        //onLongPress will execute the same function as trailing
        onLongPress: () {},
      ),
    );
  }
}
