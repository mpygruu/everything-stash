import 'package:everything_stash/models/db_model.dart';
import 'package:everything_stash/pages/new_stash_form_page.dart';
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
        title: const Text('Your stashes'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Center(
                child: Text(
                  'Additional options',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Dark theme'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Show all items'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('About this app'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                    itemBuilder: (context, i) => StashCard(data[i]),
                  );
          },
        ),
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
