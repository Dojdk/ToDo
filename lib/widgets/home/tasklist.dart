import 'package:flutter/material.dart';
import 'package:todo/widgets/home/listitem.dart';

import '../../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => ListItem(
        itemKey: ValueKey(tasks[index].id),
        task: tasks[index],
        index: index,
      ),
    );
  }
}
