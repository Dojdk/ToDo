import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/helpers/getcolor.dart';
import 'package:todo/models/task.dart';

import '../../cubit/task_cubit.dart';
import '../../theme/colors.dart';

class ListItem extends StatefulWidget {
  final Task task;
  final Key itemKey;
  final int index;
  const ListItem({
    super.key,
    required this.itemKey,
    required this.task,
    required this.index,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late TaskCubit taskCubit;
  @override
  void initState() {
    super.initState();
    taskCubit = BlocProvider.of<TaskCubit>(context);
  }

  bool delete = true;
  bool first = true;
  Task? _deletedTask;
  int? _deletedTaskIndex;

  Widget _dismissBackground() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(right: 16, bottom: 8, top: 8),
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
                style: TextStyle(color: fancyblack),
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
      key: widget.itemKey,
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
        onTap: () {},
        child: Container(
          height: 60,
          margin: const EdgeInsets.only(right: 16, bottom: 8, top: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all<Color>(
                    getcolor(tasktype: widget.task.tasktype)),
                value: widget.task.isDone,
                shape: const CircleBorder(),
                onChanged: (bool) {},
              ),
              Text(
                widget.task.name,
                style: TextStyle(
                  decorationThickness: 2,
                  decoration:
                      widget.task.isDone ? TextDecoration.lineThrough : null,
                  color: fancyblack,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
