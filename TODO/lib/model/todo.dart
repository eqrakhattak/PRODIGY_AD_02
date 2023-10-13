import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoTime;
  String? todoTask;
  bool isDone;
  Color backgroundColor;
  DateTime todoDate;

  ToDo({
    required this.id,
    required this.todoTime,
    required this.todoTask,
    this.isDone = false,
    required this.backgroundColor,
    required this.todoDate,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoTime: '07:30', todoTask: 'Morning Exercise', backgroundColor: Colors.red, todoDate: DateTime(2023, 10, 11),),
      ToDo(id: '02', todoTime: '08:00', todoTask: 'Buy Groceries', backgroundColor: Colors.purple, todoDate: DateTime(2023, 10, 11),),
      ToDo(id: '03', todoTime: '09:00', todoTask: 'Check Emails', backgroundColor: Colors.teal, todoDate: DateTime(2023, 10, 12),),
      ToDo(id: '04', todoTime: '09:25', todoTask: 'Team Meeting', backgroundColor: Colors.blue, todoDate: DateTime(2023, 10, 12),),
      ToDo(id: '05', todoTime: '10:00', todoTask: 'Work on mobile apps for 2 hours', backgroundColor: Colors.yellow, todoDate: DateTime(2023, 10, 12),),
      ToDo(id: '06', todoTime: '21:00', todoTask: 'Dinner with Jenny', backgroundColor: Colors.orangeAccent, todoDate: DateTime(2023, 10, 12),),
    ];
  }

  // Add a method to convert a To/Do object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoTime': todoTime,
      'todoTask': todoTask,
      'backgroundColor': backgroundColor.value,
      'todoDate': todoDate.toIso8601String(),
    };
  }

  // Add a factory method to create a To/Do object from JSON
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoTime: json['todoTime'],
      todoTask: json['todoTask'],
      backgroundColor: Color(json['backgroundColor']),
      // Assuming that 'todoDate' is stored as a String in ISO8601 format in your JSON
      todoDate: DateTime.parse(json['todoDate']),
    );
  }
}