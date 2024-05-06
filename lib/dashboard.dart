import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/helper/Todos.dart';
import 'package:todo_app/helper/todo_model.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/checkbox.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  List<Todo> todos = [];
  List<Todo> todayTodo = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    todos = Todos.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    todayTodo = todos
        .where((element) => element.dueDate
            .endsWith(DateFormat('dd-MMM-yy').format(DateTime.now())))
        .toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        text: 'Add a new task',
        onTap: () => showDialog(
          builder: (context) {
            taskNameController.text = "";
            dueDateController.text =
                DateFormat('dd-MMM-yy').format(DateTime.now());
            return Dialog(
              child: dialogBox(
                  title: "Add a new task",
                  buttonText: "Add task",
                  onTap: () {
                    setState(() {
                      todos.add(Todo(
                          isCompleted: false,
                          task: taskNameController.text,
                          dueDate: dueDateController.text));
                    });
                    box.put('todos', todos);
                    Todos.write(todos);
                    Navigator.pop(context);
                  }),
            );
          },
          context: context,
        ),
      ),
      body: todos.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  todayTodo.isNotEmpty
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Today\'s Todos',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).dividerColor,
                            ),
                            buildTodo(todos
                                .where((element) => element.dueDate.endsWith(
                                    DateFormat('dd-MMM-yy')
                                        .format(DateTime.now())))
                                .toList()),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'All Todos',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  buildTodo(todos),
                  const SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ))
          : Center(
              child: Text(
                'No todos to display',
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).dividerColor),
              ),
            ),
    );
  }

  Widget buildTodo(List todos) {
    return Column(
      children: todos.map(
        (todo) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                  color: todo.isCompleted
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).primaryColor,
                  border: Border.all(
                      width: 1.5,
                      color: todo.isCompleted
                          ? Theme.of(context).focusColor
                          : Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomCheck(
                          onChanged: (value) {
                            setState(() {
                              todo.isCompleted = value;
                            });
                            Todos.write(this.todos);
                          },
                          value: todo.isCompleted,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            todo.task,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            taskNameController.text = todo.task;
                            dueDateController.text = todo.dueDate;
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: dialogBox(
                                    title: 'Update the task',
                                    buttonText: 'Update',
                                    onTap: () {
                                      setState(() {
                                        todo.task = taskNameController.text;
                                        todo.dueDate = dueDateController.text;
                                      });
                                      Todos.write(this.todos);
                                      Navigator.pop(context);
                                    }),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor),
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              this.todos.remove(todo);
                            });
                            Todos.write(this.todos);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor),
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget dialogBox({required title, required buttonText, required onTap}) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      shape: BoxShape.circle,
                      color: Theme.of(context).highlightColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor)),
                    labelStyle: TextStyle(
                      color: Theme.of(context).dividerColor,
                    ),
                    hintText: 'Name of task'),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: TextField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 5),
                  ).then((date) {
                    if (date == null) {
                      dueDateController.text = DateFormat('dd-MMM-yy')
                          .format(DateTime.now())
                          .toString();
                    } else {
                      dueDateController.text =
                          DateFormat('dd-MMM-yy').format(date).toString();
                    }
                  });
                },
                controller: dueDateController,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                    hintFadeDuration: const Duration(milliseconds: 100),
                    suffixIcon: const Icon(Icons.date_range),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor)),
                    labelStyle: TextStyle(
                      color: Theme.of(context).dividerColor,
                    ),
                    hintText: 'Due Date'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(text: buttonText, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
