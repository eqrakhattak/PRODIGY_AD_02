import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todoProvider.dart';
import 'package:todo/widgets/todoEditorWidget.dart';

class TodoWidget extends StatefulWidget {
  final ToDo todo;
  // final Color randomColor;
  //
  // TodoWidget({Key? key, required this.todo}) : randomColor = getRandomColor(), super(key: key);

  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();

  // static Color getRandomColor() {
  //   final Random random = Random();
  //   return Color.fromRGBO(
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     1.0, // Alpha (fully opaque)
  //   );
  // }
}

class _TodoWidgetState extends State<TodoWidget> {

  Color _iconColor = Colors.white;
  TextDecoration _todoTextDecoration = TextDecoration.none;
  bool _editButtonVisibility = true;

  void _markAsDone(){
    setState(() {
      widget.todo.isDone = true;
      _iconColor = Colors.green;
      _todoTextDecoration = TextDecoration.lineThrough;
      _editButtonVisibility = false;
    });
  }

  void _unmarkAsDone(){
    setState(() {
      widget.todo.isDone = false;
      _iconColor = Colors.white;
      _todoTextDecoration = TextDecoration.none;
      _editButtonVisibility = true;
    });
  }

  void _editTodo(ToDo todo) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TodoEditorWidget(todo: todo),
    );
  }

  void _deleteTodo(){
    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
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
              onPressed: () {
                todoProvider.deleteTodo(widget.todo.id ?? "");
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

