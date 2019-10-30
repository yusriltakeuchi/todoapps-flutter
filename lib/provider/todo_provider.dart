
import 'package:flutter/material.dart';
import 'package:todoapps/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todoList = new List<TodoModel>();
  List<TodoModel> get getTodo => todoList;

  Future<void> addTodo(TodoModel todo) {
    todoList.add(todo);
    notifyListeners();
  }

  Future<void> removeTodo(int index) {
    todoList.removeAt(index);
    notifyListeners();
  }
}