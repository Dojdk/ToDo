import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../pages/homepage.dart';
import '../pages/addtaskpage.dart';
import '../pages/categorypage.dart';

import 'cubit/task/task_cubit.dart';
import 'cubit/type/type_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: lightGrey));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(),
        ),
        BlocProvider<TypeCubit>(
          create: (context) => TypeCubit(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          scaffoldBackgroundColor: lightGrey,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              fontSize: 12,
              color: grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme:
              AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        home: const HomePage(),
        routes: {
          AddTaskPage.routeName: (context) => const AddTaskPage(),
          CategoryPage.routeName: (context) => const CategoryPage(),
        },
      ),
    );
  }
}
