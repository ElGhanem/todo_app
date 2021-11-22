import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Database/Models/todo.dart';

CollectionReference<Todo> getTodosRefWithConverters() {
  return FirebaseFirestore.instance.collection('todos').withConverter<Todo>(
      fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
      toFirestore: (todo, _) => todo.toJson()
  );
}

Future<void> addTodoToFireStore(Todo todo) {
  DocumentReference doc = getTodosRefWithConverters().doc();
  todo.id = doc.id;
  return doc.set(todo);
}