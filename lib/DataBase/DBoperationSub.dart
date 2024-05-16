import 'package:first/Screen/ListScreen.dart';
import 'package:first/noteObject.dart';
import 'package:sqflite/sqflite.dart';

late Database _db;
Future<void> DBopenerSub() async {
  try {
    _db = await openDatabase(
      'notesub.db',
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notesub (id INTEGER PRIMARY KEY, name TEXT, description TEXT, time TEXT, category TEXT)',
        );
      },
    );
    print(_db);
  } catch (e) {
    // Handle error
    print("Error opening database: $e");
  }
}

Future<void> getAllNoteSub(String title) async {
  try {

    //subNoteNotifier.value.add(subNote(id: 2, name: "bbsbvu", discription: 'discription', time: 'time', category: 'category'));
    final _values = await _db.rawQuery('SELECT * FROM notesub WHERE category = ? order by id desc',[title]);
    print(_values);
    subNoteNotifier.value.clear();
    _values.forEach((element) {
      final note = subNote.mapToSubObject(element);      
      subNoteNotifier.value.add(note);
    });
  
    subNoteNotifier.notifyListeners();
  } catch (e) {
    // Handle error
    print("Error getting all notes: $e");
  }
} 

Future<void> insertNoteSub(String name, String description, String time, String category) async {
  try {
    await _db.rawInsert(
      'INSERT INTO notesub (name, description, time, category) VALUES (?, ?, ?, ?)',
      [name, description, time, category],
    );
    await getAllNoteSub(category);
  } catch (e) {
    // Handle error
    print("Error inserting note: $e");
  }
}

Future<void> deleteDataSub(int id,String title)async{
  _db.rawDelete('DELETE FROM notesub WHERE id = ?',[id]);
  getAllNoteSub(title);
}