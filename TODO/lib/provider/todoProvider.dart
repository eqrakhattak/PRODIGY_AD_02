import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDo> todosList = ToDo.todoList();

  void addTodo(ToDo todo) {
    todosList.add(todo);
    notifyListeners();
  }

  void deleteTodo(BuildContext context, String todoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todosList.removeWhere((todo) => todo.id == todoId);
                notifyListeners();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
