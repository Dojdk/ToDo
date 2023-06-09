import 'package:flutter/material.dart';
import '../../cubit/type/type_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/type.dart';

class TypeDropDown extends StatefulWidget {
  final Function update;
  const TypeDropDown({super.key, required this.update});

  @override
  State<TypeDropDown> createState() => _TypeDeopDownState();
}

class _TypeDeopDownState extends State<TypeDropDown> {
  late final types = BlocProvider.of<TypeCubit>(context).getTypes;
  late TaskType tasktype = types[0];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox.shrink(),
      value: tasktype,
      items: types
          .map<DropdownMenuItem<TaskType>>(
            (e) => DropdownMenuItem<TaskType>(
              value: e,
              child: Text(
                e.name,
                style: TextStyle(
                  color: e.color,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(
          () {
            tasktype = value as TaskType;
            widget.update(tasktype);
          },
        );
      },
    );
  }
}
