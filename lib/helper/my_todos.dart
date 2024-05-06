import 'package:hive/hive.dart';
import 'package:todo_app/helper/todo_model.dart';

part 'my_todos.g.dart';

@HiveType(typeId: 1)
class MyTodos extends HiveObject {
  @HiveField(0)
  List<Todo> todoItems;

  MyTodos(this.todoItems);
}