import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/errorwidget.dart';
import '../widgets/home/tasklist.dart';
import '../cubit/task/task_cubit.dart';
import '../theme/textstyle.dart';

class TasksPage extends StatelessWidget {
  static const routeName = '/tasks';
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final typeId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskLoaded) {
            final neededTasks = state.tasks
                .where((element) => element.typeId == typeId)
                .toList();
            if (neededTasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      'No tasks assigned to this category.',
                      style: headline,
                    ),
                    Image.asset(
                      'assets/images/png/emptychest.png',
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR TASKS:',
                      style: headline,
                    ),
                    Expanded(
                      child: TaskList(tasks: neededTasks),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const ErrorStateWidget();
          }
        },
      ),
    );
  }
}
