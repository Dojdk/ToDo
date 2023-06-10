import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
