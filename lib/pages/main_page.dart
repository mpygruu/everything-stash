import 'package:everything_stash/models/db_model.dart';
import 'package:everything_stash/pages/new_stash_form.dart';
import 'package:everything_stash/widgets/stash_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var db = DatabaseConnector();

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
        child: FutureBuilder(
          future: db.getStashes(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var data = snapshot.data; //this is the list of stashes
            var datalength = data!.length;

            return datalength == 0
                ? const Center(child: Text('You have no stashes'))
                : ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, i) => StashCard(
                      title: data[i].title,
                      description: data[i].description,
                    ),
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
