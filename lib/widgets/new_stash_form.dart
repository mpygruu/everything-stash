import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/stash.dart';
import '../pages/main_page.dart';

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
      child: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
                icon: Icon(Icons.storage_rounded),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: titleController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
                icon: Icon(Icons.description),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: descriptionController,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  var db = DatabaseConnector();
                  db.insertStash(
                    Stash(
                        title: titleController.text,
                        description: descriptionController.text),
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const MainPage()));
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
