import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

import '../theme/colors.dart';

Color getcolor({required Tasktype tasktype}) {
  switch (tasktype) {
    case Tasktype.personal:
      return blue;
    case Tasktype.business:
      return pink;
      }
}
