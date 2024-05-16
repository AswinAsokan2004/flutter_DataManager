import 'package:flutter/foundation.dart';
class Note {
  final int id;
  final String category;
  final String description;
  final String date;

  Note({required this.id,required this.category, required this.description, required this.date});

  static Note mapToObject(Map<String, Object?> map) {
  final id = map['id'] as int;
  final category = map['category'] as String;
  final description = map['description'] as String;
  final date = map['date'] as String;

  return Note(id: id, category: category, description: description, date: date);
}

}


class subNote{
  final int id;
  final String name;
  final String description;
  final String time;
  final String category;

  subNote({required this.id, required this.name, required this.description, required this.time, required this.category});
  static subNote mapToSubObject(Map<String, Object?> map){
    final id = map['id'] as int;
    final name = map['name'] as String;
     final time = map['time'] as String;
    final category = map['category'] as String;
    final discription = map['description'] as String;
    return subNote(id: id, name: name,description: discription,time: time, category: category);
  }
}
