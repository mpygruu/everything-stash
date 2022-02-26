import 'package:everything_stash/pages/new_stash_form.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () {},
        ),
        title: const Text('Your stashes'),
      ),
      body: Center(
        child: ListView(
          children: const <Widget>[
            StashCard(
                name: 'Stash 1',
                comment: 'comments are there for short description'),
            StashCard(
                name: 'Stash 2',
                comment: 'comments are there for short description'),
            StashCard(
                name: 'Stash 3',
                comment: 'comments are there for short description'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (buildContext) => const NewStashFormPage()));
        },
        tooltip: 'Add a new stash',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StashCard extends StatelessWidget {
  final String? name;
  final String? comment;

  const StashCard({this.name, this.comment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.storage_rounded, size: 38),
        title: Text(name.toString()),
        subtitle: Text(comment.toString()),
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
