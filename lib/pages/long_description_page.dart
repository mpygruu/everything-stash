import 'package:flutter/material.dart';

class LongDescriptionPage extends StatelessWidget {
  final String? name;
  final String? longDescription;
  const LongDescriptionPage(
      {required this.name, required this.longDescription, Key? key})
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
        title: Text('$name long description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: longDescription!.isNotEmpty
            ? Text('$longDescription')
            : const Text('No long description provided.'),
      ),
    );
  }
}
