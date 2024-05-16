import 'package:first/noteObject.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Note>> noteNotifier = ValueNotifier([]);
late Database _db;

Future<void> DBopener() async {
  try {
    _db = await openDatabase(
      'note.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY, category TEXT, description TEXT, date TEXT)',
        );
      },
    );
  } catch (e) {
    // Handle error
    print("Error opening database: $e");
  }
}

Future<void> getAllNote() async {
  try {
    final _values = await _db.rawQuery('SELECT * FROM note');
    noteNotifier.value.clear();
    _values.forEach((element) {
      final note = Note.mapToObject(element);
      noteNotifier.value.add(note);
    });
    noteNotifier.notifyListeners();
  } catch (e) {
    // Handle error
    print("Error getting all notes: $e");
  }
}

Future<void> insertNote(String category, String description, String date) async {
  try {
    await _db.rawInsert(
      'INSERT INTO note (category, description, date) VALUES (?, ?, ?)',
      [category, description, date],
    );
    await getAllNote();
  } catch (e) {
    // Handle error
    print("Error inserting note: $e");
  }
}
Future<void> deleteData(int id)async{
  _db.rawDelete('DELETE FROM Note WHERE id = ?',[id]);
  getAllNote();
}