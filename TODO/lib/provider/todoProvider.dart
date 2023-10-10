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

  void editTodo(String todoId, String updatedTask, String updatedTime) {
    final todo = todosList.firstWhere((todo) => todo.id == todoId, orElse: () => ToDo(id: '', todoTime: '', todoTask: '', backgroundColor: Colors.white));

    todo.todoTask = updatedTask;
    todo.todoTime = updatedTime;
    notifyListeners();
  }
}
