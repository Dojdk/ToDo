import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/widgets/home/categories.dart';
import 'package:todo/widgets/home/tasklist.dart';

import '../bloc/task_bloc.dart';
import '../models/task.dart';
import '../theme/colors.dart';

import 'addtask.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasks = state.allTasks;

        Widget bodyWithoutText() {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CATEGORIES',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 10),
                SizedBox(height: 150, child: CategoriesList(tasks: tasks)),
                Text(
                  'Today\'s Tasks',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Expanded(
                    child: TaskList(
                  tasks: tasks,
                )),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: const Icon(Icons.menu, color: fancygrey),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: fancygrey),
                onPressed: () {
                  context.read<TaskBloc>().add(const AddTask(
                        taskname: 'test',
                        tasktype: Tasktype.personal,
                      ));
                },
              ),
              IconButton(
                icon:
                    const Icon(Icons.notifications_outlined, color: fancygrey),
                onPressed: () {
                  context.read<TaskBloc>().add(const AddTask(
                        tasktype: Tasktype.business,
                        taskname: 'test',
                      ));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddTaskPage.routeName);
            },
            backgroundColor: blue,
            child: const Icon(
              Icons.add,
            ),
          ),
          body: Padding(
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
                tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks yet\nAdd Task by tapping on blue button',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    : bodyWithoutText(),
              ],
            ),
          ),
        );
      },
    );
  }
}
