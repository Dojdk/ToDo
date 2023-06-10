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
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category Page',
                      style: headline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'YOUR CATEGORIES',
                      style: headlineSmall,
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
