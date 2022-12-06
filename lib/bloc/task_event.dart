part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable{
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class TaskLoadEvent extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class TaskIsDone extends TaskEvent {
  final Task task;

  const TaskIsDone(this.task);

  @override
  List<Object> get props => [task];
}

class TaskIsNotDone extends TaskEvent {
  final Task task;

  const TaskIsNotDone(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask(this.task);

  @override
  List<Object> get props => [task];
}