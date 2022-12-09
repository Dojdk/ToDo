import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

import '../../helpers/getcolor.dart';

class TypeDeopDown extends StatefulWidget {
  final Function update;
  const TypeDeopDown({super.key, required this.update});

  @override
  State<TypeDeopDown> createState() => _TypeDeopDownState();
}

class _TypeDeopDownState extends State<TypeDeopDown> {
  Tasktype tasktype = Tasktype.personal;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: const SizedBox.shrink(),
        value: tasktype,
        items: Tasktype.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e.name,
                  style: TextStyle(
                    color: getcolor(tasktype: e),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            tasktype = value as Tasktype;
            widget.update(tasktype);
          });
        });
  }
}
