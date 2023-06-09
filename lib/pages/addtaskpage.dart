import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/widgets/addtask/dropdown.dart';

import '../cubit/task/task_cubit.dart';
import '../cubit/type/type_cubit.dart';
import '../models/task.dart';
import '../models/type.dart';
import '../theme/colors.dart';

class AddTaskPage extends StatefulWidget {
  static const routeName = '/addtas';
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final types = BlocProvider.of<TypeCubit>(context).getTypes;
  late TaskType tasktype = types[0];
  void _updateTaskType(TaskType type) {
    tasktype = type;
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(top: 20.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Form(
              child: TextFormField(
                controller: controller,
                maxLines: 8,
                cursorColor: blue,
                cursorHeight: 50,
                style: const TextStyle(fontSize: 30),
                decoration: const InputDecoration(
                  hintText: 'Enter New Task',
                  hintStyle: TextStyle(fontSize: 30),
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TypeDropDown(update: _updateTaskType),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<TaskCubit>(context).addTask(
                        Task(
                          id: DateTime.now().millisecondsSinceEpoch,
                          name: controller.text,
                          typeId: tasktype.id,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('New Task'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
