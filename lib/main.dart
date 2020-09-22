import 'package:flutter/material.dart';
import 'package:todo_app/features/todo_app/presentation/pages/todo_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
      ),
      home: TodoPage(),
    );
  }
}
