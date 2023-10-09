import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider/todoProvider.dart';

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

  void _done(){
    setState(() {
      widget.todo.isDone = true;
      iconColor = Colors.green;
      todoTextDecoration = TextDecoration.lineThrough;
      editButtonVisibility = false;
    });
  }

  void _edit(){

  }

  @override
  Widget build(BuildContext context) {

    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);

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
                  onPressed: _done,
                  icon: Icon(Icons.done, color: iconColor,),
                  padding: const EdgeInsets.all(5.0),
                  constraints: const BoxConstraints(),
                  tooltip: 'mark as done',
                ),
                Visibility(
                  visible: editButtonVisibility,
                  child: IconButton(
                    onPressed: _edit,
                    icon: const Icon(CupertinoIcons.pencil),
                    padding: const EdgeInsets.all(5.0),
                    constraints: const BoxConstraints(),
                    tooltip: 'edit task',),
                ),
                IconButton(
                  onPressed: () {
                    todoProvider.deleteTodo(widget.todo.id ?? "");
                  },
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

