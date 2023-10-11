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
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            activeColor: Colors.indigo,
            headerProps: EasyHeaderProps(
              selectedDateStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20.0,),
              selectedDateFormat: SelectedDateFormat.fullDateDayAsStrMY,
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
          Consumer<ToDoProvider>(
            builder: (context, todoProvider, child) {
              // Sort the todos list by time in ascending order
              todoProvider.todosList.sort((a, b) {
                final timeA = DateTime.parse('2023-10-08 ${a.todoTime}:00');
                final timeB = DateTime.parse('2023-10-08 ${b.todoTime}:00');
                return timeA.compareTo(timeB);
              });
              return Expanded(
                child: ListView.builder(
                  itemCount: todoProvider.todosList.length,
                  itemBuilder: (context, index) {
                    return TodoWidget(todo: todoProvider.todosList[index]);
                  },
                  physics: const BouncingScrollPhysics(),
                ),
              );
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
