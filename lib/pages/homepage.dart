import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/task/task_cubit.dart';
import '../cubit/type/type_cubit.dart';
import '../theme/colors.dart';
import '../widgets/home/categories.dart';
import '../widgets/home/tasklist.dart';
import 'addtaskpage.dart';
import 'categorypage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks();
    BlocProvider.of<TypeCubit>(context).loadTypes();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskPage.routeName);
        },
        backgroundColor: blue,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TypeCubit, TypeState>(
          builder: (context, typeState) {
            return BlocBuilder<TaskCubit, TaskState>(
              builder: (context, taskState) {
                if (typeState is TypeError || taskState is TaskError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                if (taskState is TaskLoading || TypeState is TypeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (taskState is TaskLoaded && typeState is TypeLoaded) {
                  final tasks = taskState.tasks;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'CATEGORIES',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CategoryPage.routeName);
                              },
                              child: Text(
                                'ADD CATEGORY',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
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
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
            );
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
