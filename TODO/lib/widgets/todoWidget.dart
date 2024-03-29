import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todoProvider.dart';
import 'package:todo/widgets/todoEditorWidget.dart';

class TodoWidget extends StatefulWidget {
  final ToDo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {

  Color _iconColor = Colors.white;
  TextDecoration _todoTextDecoration = TextDecoration.none;
  bool _editButtonVisibility = true;

  void _markAsDone() async {
    setState(() {
      widget.todo.isDone = true;
      _iconColor = Colors.green;
      _todoTextDecoration = TextDecoration.lineThrough;
      _editButtonVisibility = false;
    });

    final prefs = await SharedPreferences.getInstance();
    final isDoneKey = 'isDone_${widget.todo.id}';
    await prefs.setBool(isDoneKey, true);
  }

  void _unmarkAsDone() async {
    setState(() {
      widget.todo.isDone = false;
      _iconColor = Colors.white;
      _todoTextDecoration = TextDecoration.none;
      _editButtonVisibility = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final isDoneKey = 'isDone_${widget.todo.id}';
    await prefs.setBool(isDoneKey, false);
  }

  void _editTodo(ToDo todo) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TodoEditorWidget(todo: todo),
    );
  }

  void _deleteTodo(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete?'),
          backgroundColor: Colors.red[400],
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () async {
                final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
                final prefs = await SharedPreferences.getInstance();
                const todosKey = 'todos';
                final todos = prefs.getStringList(todosKey);

                if (todos != null) {
                  // Remove the deleted to/do from the provider
                  final todoId = widget.todo.id;
                  todoProvider.deleteTodo(todoId!);

                  // Remove the deleted to/do from the shared preferences
                  final updatedTodos = todos.where((todoJson) {
                    final todo = ToDo.fromJson(jsonDecode(todoJson));
                    return todo.id != todoId;
                  }).toList();

                  await prefs.setStringList(todosKey, updatedTodos);
                }

                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo.isDone == true){
      _iconColor = Colors.green;
      _todoTextDecoration = TextDecoration.lineThrough;
      _editButtonVisibility = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.todo.backgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    widget.todo.todoTime!,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Text(
                      widget.todo.todoTask!,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18.0,
                        decoration: _todoTextDecoration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => widget.todo.isDone ? _unmarkAsDone() : _markAsDone(),
                  icon: Icon(Icons.done, color: _iconColor,),
                  padding: const EdgeInsets.all(5.0),
                  constraints: const BoxConstraints(),
                  tooltip: 'mark as done',
                ),
                Visibility(
                  visible: _editButtonVisibility,
                  child: IconButton(
                    onPressed: () => _editTodo(widget.todo),
                    icon: const Icon(CupertinoIcons.pencil),
                    padding: const EdgeInsets.all(5.0),
                    constraints: const BoxConstraints(),
                    tooltip: 'edit task',),
                ),
                IconButton(
                  onPressed: _deleteTodo,
                  icon: const Icon(CupertinoIcons.trash),
                  padding: const EdgeInsets.all(5.0),
                  constraints: const BoxConstraints(),
                  tooltip: 'delete task',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

