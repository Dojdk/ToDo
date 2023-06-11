import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/taskspage.dart';
import '../../models/task.dart';
import '../../theme/textstyle.dart';
import '../../cubit/type/type_cubit.dart';

class CategoriesList extends StatelessWidget {
  final List<Task> tasks;
  const CategoriesList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final types = BlocProvider.of<TypeCubit>(context).getTypes;
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20),
      scrollDirection: Axis.horizontal,
      itemCount: types.length,
      itemBuilder: (context, index) {
        final int amount = tasks
            .where((element) => element.typeId == types[index].id)
            .toList()
            .length;
        if (amount == 0) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(TasksPage.routeName, arguments: types[index].id),
          child: Container(
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
                    style: typeAmount,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    toBeginningOfSentenceCase(types[index].name)!,
                    style: taskType,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: tasks.isEmpty ? 0 : amount / tasks.length,
                      backgroundColor: const Color(0xffd3d4dd),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(types[index].color),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
