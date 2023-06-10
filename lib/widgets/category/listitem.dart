import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/theme/textstyle.dart';

import '../../models/type.dart';

class ListItem extends StatelessWidget {
  final TaskType type;
  const ListItem({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            type.name,
            style: taskType.copyWith(
              color: type.color,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: grey,
            ),
          ),
        ],
      ),
    );
  }
}
