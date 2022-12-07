part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class TaskLoadEvent extends TaskEvent {}

class AddTask extends TaskEvent {
  final String taskname;
  final Tasktype tasktype;

  const AddTask({required this.taskname, required this.tasktype,});

  @override
  List<Object> get props => [
    taskname,tasktype,
  ];
}

class TaskUpdate extends TaskEvent {
  final Task task;

  const TaskUpdate({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UndoDelteTask extends TaskEvent {
  final Task task;
  final int index;

  const UndoDelteTask({required this.index, required this.task});

  @override
  List<Object> get props => [task];
}