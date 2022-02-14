import 'package:flutter/material.dart';

class NewStashFormPage extends StatelessWidget {
  const NewStashFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () {
            Navigator.pop(buildContext);
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

  Widget build(BuildContext buildContext) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Name'),
            ),
          ],
        ),
      ),
    );
  }
}
