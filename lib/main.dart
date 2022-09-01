import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks_data.dart';
import 'package:todo_app/screens/home_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
