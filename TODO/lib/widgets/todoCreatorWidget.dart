import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class TodoCreatorWidget extends StatefulWidget {
  const TodoCreatorWidget({super.key});

  @override
  State<TodoCreatorWidget> createState() => _TodoCreatorWidgetState();
}

class _TodoCreatorWidgetState extends State<TodoCreatorWidget> {

  TimeOfDay time = const TimeOfDay(hour: 09, minute: 30);
  final _todoTextController = TextEditingController();
  List<ToDo> todosList = ToDo.todoList();

  void _addTodo(String todoItem, String todoInstant){
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoTime: todoInstant,
          todoTask: todoItem,
        ),
      );
    });
    Navigator.of(context).pop();
    print(todosList.length);
  }

  @override
  Widget build(BuildContext context) {
    final String hours = time.hour.toString().padLeft(2, '0');
    final String minutes = time.minute.toString().padLeft(2, '0');
    final String timeText = '$hours:$minutes';

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
              decoration: const InputDecoration(
                hintText: 'What do you want TODO?',
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
            onPressed: () => _addTodo(_todoTextController.text, timeText),
            tooltip: 'Add Task',
            child: const Icon(Icons.done),
          ),
          const SizedBox(height: 18,)
        ],
      ),
    );
  }
}