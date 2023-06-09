import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/type/type_cubit.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/categorypage';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final typeCubit = context.watch<TypeCubit>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Category Page'),
            ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text('Category $index'),
              ),
              itemCount: typeCubit.getTypes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
