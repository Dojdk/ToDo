import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/task/task_cubit.dart';
import '../../cubit/type/type_cubit.dart';
import '../../models/type.dart';
import '../../theme/textstyle.dart';

class DeletePopUp extends StatelessWidget {
  final TaskType type;
  const DeletePopUp({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Delete Type',
        style: headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'After deleting category you will also delete all tasks assigned to it.',
        style: taskTitle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: headlineSmallBlue,
          ),
        ),
        TextButton(
          onPressed: () {
            deleteType(context, type);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Delete',
            style: headlineSmallBlue,
          ),
        ),
      ],
    );
  }
}

void deleteType(BuildContext context, TaskType type) {
  context.read<TaskCubit>().removeTaskByTypeID(
        type.id,
      );
  context.read<TypeCubit>().removeType(
        type,
      );
}
