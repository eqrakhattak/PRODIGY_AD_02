import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todoProvider.dart';
import 'package:todo/screens/homePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ToDoProvider(),
      child: const MyApp(),
    ),
  );
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
