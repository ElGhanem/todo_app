import 'package:flutter/material.dart';
import 'package:todo_app/Database/Models/todo.dart';
import 'package:todo_app/Database/firebaseutils.dart';

class ListProvider extends ChangeNotifier {

  DateTime selectedDay = DateTime.now().toUtc();
  List<Todo> items = [];

  ListProvider() {
    print(selectedDay);
    selectedDay = removeTime(selectedDay);
    print(selectedDay);
  }

  void refreshTodos(int x) {
    if(x!=1) return;
    print('in refresh selectedDay $selectedDay');
    getTodosRefWithConverters().where('dateTime', isEqualTo: selectedDay).get().then((allDocuments) {
      items = allDocuments.docs.map((document) {
        return document.data();
      }).toList();
      items.sort((Todo a, Todo b) {
        return a.dateTime.compareTo(b.dateTime);
      });
      notifyListeners();
    });
  }

  void setNewSelectedDay(DateTime newSelectedDateTime) {
    selectedDay = newSelectedDateTime;
    notifyListeners();
  }

  DateTime removeTime(DateTime date) {
    date = date.subtract(Duration(hours: date.hour));
    date = date.subtract(Duration(minutes: date.minute));
    date = date.subtract(Duration(seconds: date.second));
    date = date.subtract(Duration(milliseconds: date.millisecond));
    date = date.subtract(Duration(microseconds: date.microsecond));
    return date;
  }

}