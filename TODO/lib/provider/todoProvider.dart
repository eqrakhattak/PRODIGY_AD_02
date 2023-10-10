import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDo> todosList = ToDo.todoList();

  void addTodo(ToDo todo) {
    todosList.add(todo);
    notifyListeners();
  }

  void deleteTodo(String todoId) {
    todosList.removeWhere((todo) => todo.id == todoId);
    notifyListeners();
  }
}
