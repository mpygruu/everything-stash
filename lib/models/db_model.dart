import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:everything_stash/models/stash.dart';
import 'dart:async';

import 'item.dart';

class DatabaseConnector {
  Database? _database;

  //Getter to access private database correctly
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'EverythingStashDb.db';
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  //Executed when database does not exist yet
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Stashes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT);
    ''');
    await db.execute("""
        CREATE TABLE Items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        shortDescription TEXT,
        longDescription TEXT,
        quantity INTEGER, 
        stashId INTEGER);
        """);
  }

  Future<void> insertStash(Stash stash) async {
    //connecting to database
    final db = await database;

    await db.insert(
      'stashes',
      stash.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //replacing duplicate entry
    );
  }

  Future<void> deleteStash(int? id) async {
    final db = await database;
    await db.delete(
      'stashes', //table name
      where: 'id == ?', //condition checking for id in stash list
      whereArgs: [id],
    );
  }

  Future<Stash> findStash(var title) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'stashes',
      where: 'title == ?',
      whereArgs: [title],
    );

    return Stash.fromMap(result[0]);
  }

  Future<bool> stashExists(var title) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'stashes',
      where: 'title == ?',
      whereArgs: [title],
    );

    if (result.isEmpty) return false;
    return true;
  }

  Future<List<Stash>> getStashes() async {
    final db = await database;

    //query the database and save result as a list of stash maps
    List<Map<String, dynamic>> items = await db.query(
      'stashes',
      orderBy: 'id DESC',
    );

    //converting maps to Stash objects and returing list of them
    return List.generate(
      items.length,
      (index) => Stash(
        id: items[index]['id'],
        title: items[index]['title'],
        description: items[index]['description'],
      ),
    );
  }

  Future<Stash> getStashById(int? id) async {
    final db = await database;

    List<Map<String, dynamic>> data = await db.query(
      'stashes',
      where: 'id == ?',
      whereArgs: [id],
    );

    return List.generate(
      data.length,
      (index) => Stash(
        id: data[index]['id'],
        title: data[index]['title'],
        description: data[index]['description'],
      ),
    )[0];
  }

  Future<void> changeStashTitle(int? id, var newTitle) async {
    final db = await database;
    await db
        .execute('update stashes set title = ? where id == ?', [newTitle, id]);
  }

  Future<void> changeStashDescription(int? id, var newDescription) async {
    final db = await database;
    await db.execute('update stashes set description = ? where id == ?',
        [newDescription, id]);
  }

  Future<void> insertItem(Item item) async {
    //connecting to database
    final db = await database;

    await db.insert(
      'items',
      item.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.replace, //replacing duplicate entry
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      'items', //table name
      where: 'id == ?', //condition checking for id in item list
      whereArgs: [id],
    );
  }

  Future<Item> findItem(var name) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'items',
      where: 'name == ?',
      whereArgs: [name],
    );

    return Item.fromMap(result[0]);
  }

  Future<Item> getItemById(int? id) async {
    final db = await database;

    List<Map<String, dynamic>> data = await db.query(
      'items',
      where: 'id == ?',
      whereArgs: [id],
    );

    return List.generate(
      data.length,
      (index) => Item(
        id: data[index]['id'],
        name: data[index]['name'],
        shortDescription: data[index]['shortDescription'],
        longDescription: data[index]['longDescription'],
        quantity: data[index]['quantity'],
        stashId: data[index]['stashId'],
      ),
    )[0];
  }

  Future<void> changeQuantity(int? id, int? q) async {
    final db = await database;
    await db.execute(
        'update items set quantity = quantity + ? where id == ?', [q, id]);
  }

  Future<List<Item>> getItems(int? stashId) async {
    final db = await database;

    //query the database and save result as a list of item maps
    List<Map<String, dynamic>> items = await db.query(
      'items',
      orderBy: 'id DESC',
      where: 'stashId == ?',
      whereArgs: [stashId],
    );

    //converting maps to Stash objects and returing list of them
    return List.generate(
      items.length,
      (index) => Item(
          id: items[index]['id'],
          name: items[index]['name'],
          shortDescription: items[index]['shortDescription'],
          longDescription: items[index]['longDescription'],
          quantity: items[index]['quantity'],
          stashId: items[index]['stashId']),
    );
  }

  Future<void> changeItemName(int? id, var newName) async {
    final db = await database;
    await db.execute(
      'update items set name = ? where id == ?',
      [newName, id],
    );
  }

  Future<void> changeItemShortDescription(
      int? id, var newShortDescription) async {
    final db = await database;
    await db.execute(
      'update items set shortDescription = ? where id == ?',
      [newShortDescription, id],
    );
  }

  Future<void> changeItemLongDescription(
      int? id, var newLongDescription) async {
    final db = await database;
    await db.execute(
      'update items set longDescription = ? where id == ?',
      [newLongDescription, id],
    );
  }

  Future<void> changeItemQuantity(int? id, int? quantity) async {
    final db = await database;
    await db.execute(
      'update items set quantity = ? where id == ?',
      [quantity, id],
    );
  }
}
