import 'package:flutter/material.dart';

class TodoCreatorWidget extends StatefulWidget {
  const TodoCreatorWidget({super.key});

  @override
  State<TodoCreatorWidget> createState() => _TodoCreatorWidgetState();
}

class _TodoCreatorWidgetState extends State<TodoCreatorWidget> {

  TimeOfDay time = const TimeOfDay(hour: 09, minute: 30);

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return Container(
      height: 320,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '$hours:$minutes',
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
          const SizedBox(height: 20,),
          Text('data'),
        ],
      ),
    );
  }
}