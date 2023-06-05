import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/home/categories.dart';
import 'package:todo/widgets/home/tasklist.dart';

import '../cubit/task_cubit.dart';
import '../theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<TaskCubit>(context).addTask(
              Task(id: '1', tasktype: Tasktype.personal, name: 'name'));
        },
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TaskLoaded) {
              final tasks = state.tasks;
              if (tasks.isEmpty) return _noTask();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What\'s up, Joy!',
                      style: TextStyle(
                        color: fancyblack,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CATEGORIES',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 150, child: CategoriesList(tasks: tasks)),
                          Text(
                            'Today\'s Tasks',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Expanded(
                            child: TaskList(
                              tasks: tasks,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'What\'s up, Joy!',
                      style: TextStyle(
                        color: fancyblack,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'No tasks yet\nAdd Task by tapping on blue button',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _noTask() {
  return const Center(
    child: Text(
      'No tasks yet\nAdd Task by tapping on blue button',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    ),
  );
}
