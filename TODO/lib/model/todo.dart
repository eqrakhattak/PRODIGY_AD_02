import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoTime;
  String? todoTask;
  bool isDone;
  Color backgroundColor;

  ToDo({
    required this.id,
    required this.todoTime,
    required this.todoTask,
    this.isDone = false,
    required this.backgroundColor,
  });

  static List<ToDo> todoList() {
    return [
      // ToDo(id: '01', todoTime: '07:30', todoTask: 'Morning Exercise', backgroundColor: Colors.red),
      // ToDo(id: '02', todoTime: '08:00', todoTask: 'Buy Groceries', backgroundColor: Colors.purple),
      // ToDo(id: '03', todoTime: '09:00', todoTask: 'Check Emails', backgroundColor: Colors.teal),
      // ToDo(id: '04', todoTime: '09:25', todoTask: 'Team Meeting', backgroundColor: Colors.blue),
      // ToDo(id: '05', todoTime: '10:00', todoTask: 'Work on mobile apps for 2 hours', backgroundColor: Colors.yellow),
      // ToDo(id: '06', todoTime: '21:00', todoTask: 'Dinner with Jenny', backgroundColor: Colors.orangeAccent),
    ];
  }
}