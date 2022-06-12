import 'package:everything_stash/models/db_model.dart';
import 'package:everything_stash/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../models/stash.dart';

class NewStashFormPage extends StatelessWidget {
  final bool? updateExisting;
  final String? oldTitle;
  final String? oldDescription;
  const NewStashFormPage(
      {this.updateExisting, this.oldTitle, this.oldDescription, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: updateExisting == true
            ? Text('Update stash $oldTitle')
            : const Text("New stash"),
      ),
      body: NewStashForm(
        updateExisting: updateExisting,
        oldTitle: oldTitle,
        oldDescription: oldDescription,
      ),
    );
  }
}

class NewStashForm extends StatefulWidget {
  final bool? updateExisting;
  final String? oldTitle;
  final String? oldDescription;
  const NewStashForm(
      {this.updateExisting, this.oldTitle, this.oldDescription, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewStashFormState();
}

class _NewStashFormState extends State<NewStashForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    setState(() {
      titleController.text = widget.oldTitle.toString();
      descriptionController.text = widget.oldDescription.toString();
    });
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
                  if (widget.updateExisting!) {
                    db.changeStashDescription(
                        widget.oldTitle, descriptionController.text);
                    db.changeStashTitle(widget.oldTitle, titleController.text);
                  } else {
                    db.insertStash(
                      Stash(
                          title: titleController.text,
                          description: descriptionController.text),
                    );
                  }

                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: widget.updateExisting == true
                    ? const Text('Update stash')
                    : const Text('Add new stash'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
