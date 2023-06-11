import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/type.dart';

import '../../cubit/type/type_cubit.dart';
import '../../theme/textstyle.dart';

class CreatePopUp extends StatefulWidget {
  final String? name;
  final Color? color;
  final int? id;
  const CreatePopUp({
    super.key,
    this.name,
    this.color, this.id,
  });

  @override
  State<CreatePopUp> createState() => _CreatePopUpState();
}

class _CreatePopUpState extends State<CreatePopUp> {
  late final cubit = BlocProvider.of<TypeCubit>(context);
  final textController = TextEditingController();
  Color selectedColor = Colors.white;
  late final bool isEdit = widget.name != null;
  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      textController.text = widget.name!;
    }
    if (widget.color != null) {
      selectedColor = widget.color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title:  Text(
        isEdit ? 'Edit Category' :
        'Add Category',
        style: headlineSmall,
        textAlign: TextAlign.center,
      ),
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
            height: 15,
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
          child: const Text(
            'Cancel',
            style: headlineSmallBlue,
          ),
        ),
        TextButton(
          onPressed: () {
            if (isEdit) {
              cubit.updateType(TaskType(
                  id: widget.id!,
                  name: textController.text,
                  color: selectedColor));
              Navigator.of(context).pop();
              return;
            }
            cubit.addType(TaskType(
                id: DateTime.now().millisecondsSinceEpoch,
                name: textController.text,
                color: selectedColor));
            Navigator.of(context).pop();
          },
          child:  Text(
isEdit ? 'Edit' :
            'Add',
            style: headlineSmallBlue,
          ),
        ),
      ],
    );
  }
}
