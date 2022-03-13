import 'package:everything_stash/database_helper.dart';
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

  @override
  Widget build(BuildContext buildContext) {
    TextEditingController? titleController;
    TextEditingController? descriptionController;

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
                onPressed: () async {
                  DatabaseHelper.instance.addStash(
                    Stash(
                        title: titleController!.text,
                        description: descriptionController!.text),
                  );
                  Navigator.pop(context);
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
