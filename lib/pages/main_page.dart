import 'package:everything_stash/database_helper.dart';
import 'package:everything_stash/pages/new_stash_form.dart';
import 'package:flutter/material.dart';

import '../models/stash.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        child: FutureBuilder<List<Stash>>(
          future: DatabaseHelper.instance.getStashes(),
          builder: (BuildContext context, AsyncSnapshot<List<Stash>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("Loading..."));
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      "You have no stashes.\nAdd a new stash with (+) below",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView(
                    children: snapshot.data!.map((stash) {
                      return Center(
                        child: StashCard(
                          title: stash.title,
                          description: stash.description,
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
        /*
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
        */
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) => const NewStashFormPage()));
          });
        },
        tooltip: 'Add a new stash',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StashCard extends StatelessWidget {
  final String? title;
  final String? description;

  const StashCard({this.title, this.description, Key? key}) : super(key: key);

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
