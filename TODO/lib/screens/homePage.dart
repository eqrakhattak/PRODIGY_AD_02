import 'package:flutter/material.dart';
import 'package:todo/widgets/todoWidget.dart';
import '../widgets/todoCreatorWidget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todoProvider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime selectedDate = DateTime.now();

  void _openTaskCreator() {
    showModalBottomSheet(
        context: context,
        builder: (context) => TodoCreatorWidget(selectedDate: selectedDate,)
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
          EasyDateTimeLine(
            initialDate: selectedDate,
            onDateChange: (newSelectedDate) {
              setState(() {
                selectedDate = newSelectedDate;
              });
            },
            activeColor: Colors.indigo,
            headerProps: EasyHeaderProps(
              selectedDateStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20.0,),
              selectedDateFormat: SelectedDateFormat.fullDateDayAsStrDY,
            ),
            dayProps: const EasyDayProps(
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(),
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FutureBuilder<void>(
            future: Provider.of<ToDoProvider>(context).loadTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<ToDoProvider>(
                  builder: (context, todoProvider, child) {
                    final todosForSelectedDate = todoProvider.getTodosForDate(selectedDate);
                    // Sort the todos list by time in ascending order
                    todosForSelectedDate.sort((a, b) {
                      final timeA = DateTime.parse('2023-10-08 ${a.todoTime}:00');
                      final timeB = DateTime.parse('2023-10-08 ${b.todoTime}:00');
                      return timeA.compareTo(timeB);
                    });

                    if (todosForSelectedDate.isEmpty) {
                      return Column(
                        children: [
                          const SizedBox(height: 30,),
                          Center(
                            child: Text("No todos today", style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 25),),
                          ),
                        ],
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: todosForSelectedDate.length,
                          itemBuilder: (context, index) {
                            return TodoWidget(todo: todosForSelectedDate[index]);
                          },
                          physics: const BouncingScrollPhysics(),
                        ),
                      );
                    }
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Center(child: Text('Error loading todos'));
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskCreator,
        tooltip: 'Create Task',
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
