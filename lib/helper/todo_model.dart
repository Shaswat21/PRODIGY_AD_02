import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  bool isCompleted;

  @HiveField(1)
  String task;

  @HiveField(2)
  String dueDate;

  Todo({
    required this.isCompleted,
    required this.task,
    required this.dueDate,
  });
}