import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/task.dart';

import '../../bloc/task_bloc.dart';
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
  void _onChanged(bool? value) {
    context.read<TaskBloc>().add(
          TaskUpdate(task: widget.task),
        );
  }

  bool isTapped = false;

  Future<bool> confirmDismiss() async {
    if (isTapped) {
      isTapped = false;
      return false;
    }
    return true;
  }

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
                isTapped = true;
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
      confirmDismiss: (_) async {
        return await confirmDismiss();
      },
      resizeDuration: const Duration(seconds: 2),
      direction: DismissDirection.endToStart,
      background: _dismissBackground(),
      onDismissed: (_) {
        context.read<TaskBloc>().add(
              DeleteTask(task: widget.task),
            );
      },
      child: GestureDetector(
        onTap: () {
          _onChanged(!widget.task.isDone);
        },
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
                    widget.task.tasktype == Tasktype.business ? pink : blue),
                value: widget.task.isDone,
                shape: const CircleBorder(),
                onChanged: _onChanged,
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
