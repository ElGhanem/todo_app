import 'package:cloud_firestore/cloud_firestore.dart';

class Todo{
  late String title;
  late String description;
  late bool isDone;
  late DateTime dateTime;
  late String id;

  Todo({this.id='', required this.title, required this.description, required this.dateTime, this.isDone = false});

  Todo.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['dateTime'] as Timestamp;
    id = json['id'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    isDone = json['isDone'] as bool;
    dateTime = timestamp.toDate();
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'dateTime': dateTime
    };
  }
}