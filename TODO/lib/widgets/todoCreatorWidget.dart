import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todoProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoCreatorWidget extends StatefulWidget {
  final DateTime selectedDate;
  const TodoCreatorWidget({super.key, required this.selectedDate,});

  @override
  State<TodoCreatorWidget> createState() => _TodoCreatorWidgetState();
}

class _TodoCreatorWidgetState extends State<TodoCreatorWidget> {

  TimeOfDay time = const TimeOfDay(hour: 09, minute: 30);
  final _todoTextController = TextEditingController();

  Future<void> _addTodo(String todoItem, String todoInstant, DateTime selectedDate) async {
    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
    final Random random = Random();

    final newTodo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoTime: todoInstant,
      todoTask: todoItem,
      backgroundColor: Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0, // Alpha (fully opaque)
      ),
      todoDate: selectedDate,
    );

    todoProvider.addTodo(newTodo);
    Navigator.of(context).pop();

    // To save todos
    final prefs = await SharedPreferences.getInstance();
    final todosAsJson = todoProvider.todosList.map((todo) => todo.toJson()).toList();
    final todosAsString = todosAsJson.map((json) => jsonEncode(json)).toList();
    await prefs.setStringList('todos', todosAsString);
  }

  @override
  Widget build(BuildContext context) {
    final String hours = time.hour.toString().padLeft(2, '0');
    final String minutes = time.minute.toString().padLeft(2, '0');
    final String timeText = '$hours:$minutes';

    final String todoControllerText = _todoTextController.text.trim();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color: Colors.yellow[400],
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _todoTextController,
                  style: const TextStyle(
                      color: Colors.black
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Buy Groceries..',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeText,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newtime = await showTimePicker(context: context, initialTime: time);
                      //if Cancel => null
                      if (newtime == null) return;
                      //if OK => TimeOfDay
                      setState(() => time = newtime);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              FloatingActionButton(
                onPressed: () {
                  if(todoControllerText.isNotEmpty){
                    _addTodo(todoControllerText, timeText, widget.selectedDate);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Enter todo item & Select time",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                    );
                  }
                },
                tooltip: 'Add Task',
                backgroundColor: Colors.indigo,
                child: const Icon(Icons.done, color: Colors.white,),
              ),
              const SizedBox(height: 18,)
            ],
          ),
        );
      },
    );
  }
}