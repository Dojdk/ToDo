import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import 'package:flutter/material.dart';

import '../../helpers/getcolor.dart';
import '../../models/task.dart';
import '../../theme/colors.dart';

class CategoriesList extends StatelessWidget {
  final List<Task> tasks;
  const CategoriesList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Tasktype.values.length,
      itemBuilder: (context, index) {
        final int amount = tasks
            .where((element) => element.tasktype == Tasktype.values[index])
            .length;
        if (amount == 0) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(right: 16, bottom: 8, top: 8),
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$amount tasks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  toBeginningOfSentenceCase(Tasktype.values[index].name)!,
                  style: const TextStyle(
                    color: fancyblack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: tasks.isEmpty ? 0 : amount / tasks.length,
                    backgroundColor: const Color(0xffd3d4dd),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        getcolor(tasktype: Tasktype.values[index])),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
