import 'package:flutter/material.dart';
import '../widgets/new_stash_form.dart';

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
