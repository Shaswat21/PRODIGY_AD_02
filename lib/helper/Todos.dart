import 'package:todo_app/helper/my_todos.dart';
import 'package:todo_app/main.dart';

import 'todo_model.dart';

class Todos {
  static void write(List<Todo> todos) {
    box.put('todos', MyTodos(todos));
  }

  static List<Todo> getTodos() {
    MyTodos t = box.get('todos');
    if (t.todoItems.isNotEmpty) {
      return t.todoItems.toList();
    }
    return [];
  }
}
