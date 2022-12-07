part of 'task_bloc.dart';

@immutable
class TaskState extends Equatable {
  final List<Task> allTasks;
  const TaskState({this.allTasks = const <Task>[]});

  @override
  List<Object> get props => [allTasks];
}

class TaskInitial extends TaskState {
  const TaskInitial({List<Task> allTasks = const <Task>[]});
  @override
  List<Object> get props => [allTasks];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasklist;

  const TaskLoaded([this.tasklist = const []]);

  @override
  List<Object> get props => [tasklist];
}
