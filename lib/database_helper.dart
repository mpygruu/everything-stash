import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'models/stash.dart';

class DatabaseHelper {
  DatabaseHelper._privateContructor();
  static final DatabaseHelper instance = DatabaseHelper._privateContructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'stashes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE stashes(id INTEGER PRIMARY KEY, name TEXT, description TEXT)''');
  }

  Future<List<Stash>> getStashes() async {
    Database db = await instance.database;
    var stashes = await db.query('stashes', orderBy: 'name');
    List<Stash> stashList =
        stashes.isNotEmpty ? stashes.map((c) => Stash.fromMap(c)).toList() : [];
    return stashList;
  }

  Future<int> addStash(Stash stash) async {
    Database db = await instance.database;
    return await db.insert('stashes', stash.toMap());
  }
}
