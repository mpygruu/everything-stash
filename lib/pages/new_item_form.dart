import 'package:everything_stash/pages/item_list_page.dart';
import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/item.dart';
import '../models/stash.dart';

class NewItemFormPage extends StatelessWidget {
  final Stash? stash;
  const NewItemFormPage({required this.stash, Key? key}) : super(key: key);

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
        title: Text('New item in ${stash!.title}'),
      ),
      body: NewItemForm(stash: stash),
    );
  }
}

class NewItemForm extends StatefulWidget {
  final Stash? stash;
  const NewItemForm({required this.stash, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final longDescriptionController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Item name'),
              controller: nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Short description'),
              controller: shortDescriptionController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Long description'),
              controller: longDescriptionController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Quantity'),
              controller: quantityController,
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: ElevatedButton(
                onPressed: () {
                  var db = DatabaseConnector();
                  db.insertItem(
                    Item(
                      name: nameController.text,
                      shortDescription: shortDescriptionController.text,
                      longDescription: longDescriptionController.text,
                      quantity: int.parse(quantityController.text),
                      stashId: widget.stash!.id,
                    ),
                  );
                  //Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemListPage(
                        stash: widget.stash,
                      ),
                    ),
                  );
                },
                child: const Text('Add new item'),
              ),
            )
          ],
        ),
      ),
    );
  }
}