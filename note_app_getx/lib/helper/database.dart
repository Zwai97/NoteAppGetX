import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const String _dbName = 'notesDb.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'Notes';

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await init();
      return _database;
    }
  }

  Future<Database> init() async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    String path = join(dbPath.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        dateTimeEdited TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
            ''');
    // ignore: avoid_print, dead_code
    print('=============================onCreate');
  }

  Future<List<Note>> getAllNotes() async {
    final Database? db = await database;
    final List<Map<String, Object?>> listMap = await db!.query(_tableName);
    final List<Note> listNote = [];
    for (var li in listMap) {
      listNote.add(Note.fromMap(li));
    }
    return listNote;
  }

  Future<int> addNote(Note note) async {
    final Database? db = await database;
    return await db!.insert(_tableName, note.toMap());
  }

  Future<int> updateNote(Note note) async {
    final Database? db = await database;
    return await db!.update(
      _tableName,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(Note note) async {
    final Database? db = await database;
    return await db!.delete(_tableName, where: " id= ?", whereArgs: [note.id]);
  }

  Future<int> deleteAllNotes() async {
    Database? db = await database;
    return await db!.delete(_tableName);
  }
}
