import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Color iconColor = Colors.white;
  TextDecoration todoTextDecoration = TextDecoration.none;
  bool editButtonVisibility = true;

  void _completeTodo(){
    setState(() {
      widget.todo.isDone = true;
      iconColor = Colors.green;
      todoTextDecoration = TextDecoration.lineThrough;
      editButtonVisibility = false;
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
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoProvider.deleteTodo(widget.todo.id ?? "");
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return Card(
      color: Colors.amber,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 10, 0, 10),
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
                        decoration: todoTextDecoration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _completeTodo,
                  icon: Icon(Icons.done, color: iconColor,),
                  padding: const EdgeInsets.all(5.0),
                  constraints: const BoxConstraints(),
                  tooltip: 'mark as done',
                ),
                Visibility(
                  visible: editButtonVisibility,
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

