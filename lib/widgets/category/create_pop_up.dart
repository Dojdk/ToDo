import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/type.dart';

import '../../cubit/type/type_cubit.dart';
import '../../theme/textstyle.dart';

class CreatePopUp extends StatefulWidget {
  const CreatePopUp({
    super.key,
  });

  @override
  State<CreatePopUp> createState() => _CreatePopUpState();
}

class _CreatePopUpState extends State<CreatePopUp> {
  late final cubit = BlocProvider.of<TypeCubit>(context);

  final textController = TextEditingController();
  Color selectedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Add Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            child: TextFormField(
              controller: textController,
              style: taskTitle,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                hintStyle: taskTitle,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              selectedColor = await showColorPickerDialog(
                context,
                Colors.white,
              );
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Picked Color:',
                  style: taskTitle,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: selectedColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            cubit.addType(TaskType(
                id: DateTime.now().millisecondsSinceEpoch,
                name: textController.text,
                color: selectedColor));
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
