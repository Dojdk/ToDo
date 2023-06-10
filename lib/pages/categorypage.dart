import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/category/listitem.dart';
import '../widgets/category/create_pop_up.dart';
import '../theme/textstyle.dart';
import '../theme/colors.dart';
import '../cubit/type/type_cubit.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/categorypage';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const CreatePopUp();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TypeCubit, TypeState>(
        builder: (context, state) {
          if (state is TypeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TypeLoaded) {
            if (state.types.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      'No categories yet.\nAdd by pressing + button.',
                      style: headline,
                    ),
                    Image.asset(
                      'assets/images/png/emptychest.png',
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR CATEGORIES:',
                      style: headline,
                    ),
                 
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            ListItem(type: state.types[index]),
                        itemCount: state.types.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Something went wrong',
                style: headline,
              ),
            );
          }
        },
      ),
    );
  }
}
