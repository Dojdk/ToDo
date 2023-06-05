import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/homepage.dart';
import '../pages/addtask.dart';
import 'cubit/task_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              fontSize: 12,
              color: fancygrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme:
              AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        home: const HomePage(),
        routes: {
          AddTaskPage.routeName: (context) => const AddTaskPage(),
        },
      ),
    );
  }
}
