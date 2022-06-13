import 'package:everything_stash/widgets/item_card.dart';
import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/stash.dart';
import 'new_item_form.dart';

class ItemListPage extends StatefulWidget {
  final Stash? stash;
  const ItemListPage({required this.stash, Key? key}) : super(key: key);

  @override
  State<ItemListPage> createState() => _ItemListPage();
}

class _ItemListPage extends State<ItemListPage> {
  void refreshPage() {
    setState(() {});
  }

  var db = DatabaseConnector();

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
        title: Text('${widget.stash!.title} items'),
      ),
      body: FutureBuilder(
        future: db.getItems(widget.stash!.id),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data; //this is the list of items
          var datalength = data!.length;

          return datalength == 0
              ? const Center(child: Text('You have no items in this stash'))
              : ListView.builder(
                  itemCount: datalength,
                  itemBuilder: (context, i) => ItemCard(
                    id: data[i].id,
                    name: data[i].name,
                    shortDescription: data[i].shortDescription,
                    longDescription: data[i].longDescription,
                    quantity: data[i].quantity.toString(),
                    stashId: data[i].stashId.toString(),
                    refreshPage: refreshPage,
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) =>
                        NewItemFormPage(stash: widget.stash)));
          });
        },
        tooltip: 'Add an item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
