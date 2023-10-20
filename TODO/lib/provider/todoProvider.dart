import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/todo.dart';
import 'dart:convert';

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
    final todo = todosList.firstWhere((todo) => todo.id == todoId, orElse: () => ToDo(
      id: '',
      todoTime: '',
      todoTask: '',
      backgroundColor: Colors.black,
      todoDate: DateTime.now(),
      // TODO: change date from now to selectedDate
    ),);

    todo.todoTask = updatedTask;
    todo.todoTime = updatedTime;
    notifyListeners();
  }

  List<ToDo> getTodosForDate(DateTime date) {
    // Use the `where` method to filter todos by the selected date
    return todosList.where((todo) {
      return todo.todoDate.year == date.year &&
          todo.todoDate.month == date.month &&
          todo.todoDate.day == date.day;
    }).toList();
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTodos = prefs.getStringList('todos');
    if (savedTodos != null) {
      todosList = savedTodos.map((jsonString) {
        final todo = ToDo.fromJson(jsonDecode(jsonString));
        final isDoneKey = 'isDone_${todo.id}';
        todo.isDone = prefs.getBool(isDoneKey) ?? false; // Load the isDone status
        return todo;
      }).toList();
      // notifyListeners();
    }
  }
}




