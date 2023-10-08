import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todoWidget.dart';
import 'widgets/todoCreatorWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TODO',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'TODO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ToDo> todosList = ToDo.todoList();

  void _openTaskCreator() {
    showModalBottomSheet(
        context: context,
        builder: (context) => const TodoCreatorWidget()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20,),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),
                  Text('B'),
                  SizedBox(width: 10,),

                ],
              ),
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Date',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                return TodoWidget(todo: todosList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskCreator,
        tooltip: 'Create Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
