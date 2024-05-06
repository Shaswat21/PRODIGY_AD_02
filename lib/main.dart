import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/dashboard.dart';
import 'package:todo_app/helper/my_todos.dart';
import 'package:todo_app/helper/todo_model.dart';
import 'package:todo_app/theme.dart';

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(MyTodosAdapter());
  box = await Hive.openBox('myTodos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const Dashboard(),
    );
  }
}
