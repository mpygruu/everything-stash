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

  Future<void> deleteStash(Stash stash) async {
    final db = await database;
    await db.delete(
      'stashes', //table name
      where: 'id == ?', //condition checking for id in stash list
      whereArgs: [stash.id],
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

  Future<void> changeStashTitle(var oldTitle, var newTitle) async {
    final db = await database;
    await db.execute(
        'update stashes set title = ? where title == ?', [newTitle, oldTitle]);
  }

  Future<void> changeStashDescription(var title, var newDescription) async {
    final db = await database;
    await db.execute('update stashes set description = ? where title == ?',
        [newDescription, title]);
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

  Future<void> deleteItem(Item item) async {
    final db = await database;
    await db.delete(
      'items', //table name
      where: 'id == ?', //condition checking for id in stash list
      whereArgs: [item.id],
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

  Future<void> changeQuantity(var name, int? q) async {
    final db = await database;
    await db.execute(
        'update items set quantity = quantity + ? where name == ?', [q, name]);
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
}
