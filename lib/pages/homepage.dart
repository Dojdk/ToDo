import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/task/task_cubit.dart';
import '../cubit/type/type_cubit.dart';
import '../models/type.dart';
import '../theme/colors.dart';
import '../theme/textstyle.dart';
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
    List<TaskType> checktypes = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (checktypes.isEmpty) {
            Navigator.of(context).pushNamed(CategoryPage.routeName);
          } else {
            Navigator.of(context).pushNamed(AddTaskPage.routeName);
          }
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
                if (taskState is TaskLoading || TypeState is TypeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (taskState is TaskLoaded && typeState is TypeLoaded) {
                  final tasks = taskState.tasks;
                  final types = typeState.types;
                  checktypes = types;
                  if (types.isEmpty) return _pageStart(context, true);
                  if (tasks.isEmpty) return _pageStart(context, false);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'What\'s up, Cutie!',
                              style: headline,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'CATEGORIES',
                                  style: headlineSmall,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(CategoryPage.routeName);
                                  },
                                  child: const Text(
                                    'ADD CATEGORY',
                                    style: headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 150, child: CategoriesList(tasks: tasks)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'YOUR TASKS',
                                style: headlineSmall,
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: TaskList(
                                  tasks: tasks,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Seems like something went wrong\nPlease try again later',
                      textAlign: TextAlign.center,
                      style: headline,
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

Widget _pageStart(BuildContext context, bool categorie) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s up, Cutie!',
          style: headline,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CATEGORIES',
              style: headlineSmall,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CategoryPage.routeName);
              },
              child: const Text(
                'ADD CATEGORY',
                style: headlineSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            categorie
                ? 'You don\'t have any categories yet.\nPlease add some to start using the app'
                : 'There is no task yet.\nPress button below to add your first task',
            style: headline,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(child: Image.asset('assets/images/png/emptychest.png'))
      ],
    ),
  );
}
