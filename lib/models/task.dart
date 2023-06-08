import 'type.dart';

class Task {
  final int id;
  final String name;
  bool isDone;
  final TaskType tasktype;

  Task({
    required this.id,
    required this.tasktype,
    required this.name,
    this.isDone = false,
  });
}
