import 'package:flutter/material.dart';

class TaskType {
  final int id;
  final String name;
  final Color color;

  TaskType({
    required this.id,
    required this.name,
    required this.color,
  });

  Map<String, Object> toMap() {
    return {
      'typeId': id,
      'name': name,
      'color': color.value,
    };
  }
}
