import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  static const routeName = '/addtas';
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: TextFormField(
                style: const TextStyle(fontSize: 30),
                decoration: const InputDecoration(
                  hintText: 'Enter New Task',
                  hintStyle: TextStyle(fontSize: 30),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
