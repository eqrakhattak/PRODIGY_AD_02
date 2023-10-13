import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todoProvider.dart';

class TodoEditorWidget extends StatefulWidget {
  final ToDo todo;

  const TodoEditorWidget({super.key, required this.todo});

  @override
  State<TodoEditorWidget> createState() => _TodoEditorWidgetState();
}

class _TodoEditorWidgetState extends State<TodoEditorWidget> {

  late TimeOfDay time; // Declare 'time' without initialization
  final _todoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoTextController.text = widget.todo.todoTask ?? "";
    // Initialize 'time' based on widget.to(/)do.todoTime
    final timeParts = (widget.todo.todoTime ?? '').split(':');
    if (timeParts.length == 2) {
      final int hour = int.tryParse(timeParts[0]) ?? 0;
      final int minute = int.tryParse(timeParts[1]) ?? 0;
      time = TimeOfDay(hour: hour, minute: minute);
    } else {
      // Default value if parsing fails
      time = const TimeOfDay(hour: 09, minute: 30);
    }
  }

  Future<void> _editTodo() async {
    final String updatedTask = _todoTextController.text.trim();
    final String updatedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    if (updatedTask.isNotEmpty) {
      final todoProvider = Provider.of<ToDoProvider>(context, listen: false);

      // Update the to/do in the provider
      todoProvider.editTodo(
        widget.todo.id ?? "",
        updatedTask,
        updatedTime,
      );

      // Update the to/do in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final savedTodos = prefs.getStringList('todos');

      if (savedTodos != null) {
        final todosList = savedTodos.map((jsonString) => ToDo.fromJson(jsonDecode(jsonString))).toList();
        final index = todosList.indexWhere((todo) => todo.id == widget.todo.id);
        if (index != -1) {
          final updatedTodo = ToDo(
            id: widget.todo.id,
            todoTime: updatedTime,
            todoTask: updatedTask,
            backgroundColor: widget.todo.backgroundColor,
            todoDate: widget.todo.todoDate,
          );
          todosList[index] = updatedTodo;
        }

        final updatedTodosAsJson = todosList.map((todo) => jsonEncode(todo.toJson())).toList();
        await prefs.setStringList('todos', updatedTodosAsJson);
      }

      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    final String hours = time.hour.toString().padLeft(2, '0');
    final String minutes = time.minute.toString().padLeft(2, '0');
    final String timeText = '$hours:$minutes';

    final String todoControllerText = _todoTextController.text.trim();

    return Container(
      height: 320,
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
                _editTodo();
              } else {
                Fluttertoast.showToast(
                  msg: "Todo item can't be empty",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                );
              }
            },
            tooltip: 'Edit Task',
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.done, color: Colors.white,),
          ),
          const SizedBox(height: 18,)
        ],
      ),
    );
  }
}
