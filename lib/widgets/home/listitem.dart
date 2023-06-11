import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/task.dart';
import 'package:todo/theme/textstyle.dart';

import '../../cubit/task/task_cubit.dart';
import '../../cubit/type/type_cubit.dart';
import '../../models/type.dart';

class ListItem extends StatefulWidget {
  final Task task;
  const ListItem({
    super.key,
    required this.task,
  });
  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late final TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
  late final List<TaskType> types =
      BlocProvider.of<TypeCubit>(context).getTypes;
  bool delete = true;
  bool first = true;

  Widget _dismissBackground() {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 8, top: 8, right: 20, left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('The task was deleted'),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                delete = false;
              },
              child: const Text(
                'UNDO',
                style: taskTitle,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key!,
      direction: DismissDirection.endToStart,
      resizeDuration: const Duration(seconds: 1),
      background: _dismissBackground(),
      onUpdate: (details) {
        if (first) {
          delete = true;
          first = false;
        }
      },
      onDismissed: (_) {
        taskCubit.removeTask(widget.task);
      },
      confirmDismiss: (direction) async {
        await Future.delayed(const Duration(seconds: 1));
        first = true;
        return delete;
      },
      child: GestureDetector(
        onTap: () {
          final task = widget.task;
          task.isDone = !task.isDone;
          taskCubit.updateTask(task);
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(bottom: 8, top: 8, right: 20, left: 20),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Icon(
                  size: 25,
                  widget.task.isDone
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: types
                      .firstWhere((element) => element.id == widget.task.typeId)
                      .color,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.task.name,
                  style: taskTitle.copyWith(
                    decorationThickness: 2,
                    decoration:
                        widget.task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
