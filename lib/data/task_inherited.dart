import 'package:paga_eu/components/task.dart';
import 'package:flutter/material.dart';


class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Netflix', 'Colors.red', '5', '3', "15/01/2023"  ),
    Task('Crunchynroll', 'Colors.orange', '5', '3', "15/01/2023"  ),
    Task('HBO MAX', 'Colors.purple', '5', '3', "15/01/2023"  ),
  ];

  void newTask(String name, String cor, String numeroPessoas, String numeroPessoasPago, String dataVencimento){
    taskList.add(Task(name, cor, numeroPessoas, numeroPessoasPago, dataVencimento));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
