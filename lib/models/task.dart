// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum Tasktype {
  business,
  personal,
}

class Task extends Equatable {
  final String id;
  final String name;
  bool isDone;
  final Tasktype tasktype;

  Task({
    required this.id,
    required this.tasktype,
    required this.name,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [id, name, isDone, tasktype];

  static List<Task> tasklist = [
    Task(id: '1', tasktype: Tasktype.personal, name: 'Buy Milk'),
    Task(id: '2', tasktype: Tasktype.business, name: 'Buy Eggs'),
    Task(id: '3', tasktype: Tasktype.personal, name: 'Buy Bread'),
    Task(id: '4', tasktype: Tasktype.business, name: 'Buy Butter'),
    Task(id: '5', tasktype: Tasktype.personal, name: 'Buy Cheese'),
  ];

  Task copyWith({
    String? id,
    String? name,
    bool? isDone,
    Tasktype? tasktype,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      tasktype: tasktype ?? this.tasktype,
    );
  }
}
