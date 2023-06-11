import 'package:flutter/material.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/theme/textstyle.dart';

import 'create_pop_up.dart';
import 'delete_pop_up.dart';
import '../../models/type.dart';

class ListItem extends StatelessWidget {
  final TaskType type;
  const ListItem({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              type.name,
              style: taskType.copyWith(
                color: type.color,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreatePopUp(
                      name: type.name,
                      color: type.color,
                      id: type.id,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
                color: grey,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DeletePopUp(
                      type: type,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: grey,
              ),
            ),
          ],
        ),
        const Divider(
          color: darkBlue,
        ),
      ],
    );
  }
}
