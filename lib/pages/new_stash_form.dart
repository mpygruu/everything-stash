import 'package:everything_stash/models/db_model.dart';
import 'package:everything_stash/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../models/stash.dart';

class NewStashFormPage extends StatelessWidget {
  const NewStashFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('New stash'),
      ),
      body: const NewStashForm(),
    );
  }
}

class NewStashForm extends StatefulWidget {
  const NewStashForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewStashFormState();
}

class _NewStashFormState extends State<NewStashForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Title'),
              controller: titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Description'),
              controller: descriptionController,
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: ElevatedButton(
                onPressed: () {
                  var db = DatabaseConnector();
                  db.insertStash(
                    Stash(
                        title: titleController.text,
                        description: descriptionController.text),
                  );
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: const Text('Add new stash'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
