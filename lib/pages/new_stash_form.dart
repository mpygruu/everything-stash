import 'package:everything_stash/models/db_model.dart';
import 'package:flutter/material.dart';

import '../models/stash.dart';
import 'main_page.dart';

class NewStashFormPage extends StatelessWidget {
  final bool? updateExisting;
  final int? stashId;

  const NewStashFormPage({required this.updateExisting, this.stashId, Key? key})
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
            ? const Text('Update stash')
            : const Text("New stash"),
      ),
      body: NewStashForm(
        updateExisting: updateExisting,
        stashId: stashId,
      ),
    );
  }
}

class NewStashForm extends StatefulWidget {
  final bool? updateExisting;
  final int? stashId;

  const NewStashForm({required this.updateExisting, this.stashId, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewStashFormState();
}

class _NewStashFormState extends State<NewStashForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Stash? stash;

  void ShowAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid stash'),
        content: const Text('Stash with this title already exists.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok')),
        ],
      ),
    );
  }

  Future<void> insertStash() async {
    var db = DatabaseConnector();
    bool stashExists = await db.stashExists(titleController.text);

    if (stashExists) {
      ShowAlertDialog();
    } else {
      await db.insertStash(Stash(
          title: titleController.text,
          description: descriptionController.text));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }
  }

  Future<void> updateStash() async {
    var db = DatabaseConnector();
    bool stashExists = await db.stashExists(titleController.text);

    if (stashExists) {
      Stash stash = await db.findStash(titleController.text);

      if (widget.stashId == stash.id) {
        await db.changeStashDescription(
            widget.stashId, descriptionController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      } else {
        ShowAlertDialog();
      }
    } else {
      await db.changeStashTitle(widget.stashId, titleController.text);
      await db.changeStashDescription(
          widget.stashId, descriptionController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }

    /*if (widget.updateExisting!) {
      if (stash!.title != titleController.text) {
        ShowAlertDialog();
      } else {
        await db.changeStashDescription(
            widget.stashId, descriptionController.text);
      }
      if (stash != null) {
        ShowAlertDialog();
      } else {}
    }*/
  }

  @override
  Widget build(BuildContext buildContext) {
    setState(() {
      if (widget.updateExisting!) {
        var db = DatabaseConnector();

        db.getStashById(widget.stashId).then(
          (foundStash) {
            stash = foundStash;
            titleController.text = stash!.title.toString();
            descriptionController.text = stash!.description.toString();
          },
        );
      }
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
                    updateStash();
                  } else {
                    insertStash();
                  }
                },
                child: widget.updateExisting! == true
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
