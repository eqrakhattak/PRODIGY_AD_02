import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

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

  void _delete(){
    // String id
    setState(() {
      // todosList.removeWhere((item) => item.id == id);
    });
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
                  onPressed: _delete,
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

