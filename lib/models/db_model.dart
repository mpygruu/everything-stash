import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:everything_stash/models/stash.dart';
import 'dart:async';

class DatabaseConnector {
  Database? _database;

  //Getter to access private database correctly
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'stashes.db';
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
        description TEXT)
    ''');
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

  Future<void> deleteStash(Stash? stash) async {
    final db = await database;
    await db.delete(
      'stashes', //table name
      where: 'id == ?', //condition checking for id in stash list
      whereArgs: [stash!.id],
    );
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
}
