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
    final todo = todosList.firstWhere((todo) => todo.id == todoId, orElse: () => ToDo(id: '', todoTime: '', todoTask: '', backgroundColor: Colors.black, todoDate: DateTime.now(),));

    todo.todoTask = updatedTask;
    todo.todoTime = updatedTime;
    notifyListeners();
  }

  // Get todos for a specific date
  List<ToDo> getTodosForDate(DateTime date) {
    // Use the `where` method to filter todos by the selected date
    return todosList.where((todo) {
      // Assuming that `todo.todoDate` is a DateTime property representing the todo's date
      return todo.todoDate.year == date.year &&
          todo.todoDate.month == date.month &&
          todo.todoDate.day == date.day;
    }).toList();
  }

}




