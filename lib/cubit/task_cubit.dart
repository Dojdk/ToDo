import 'package:bloc/bloc.dart';

import '../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void loadTasks() async {
    emit(TaskLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(TaskLoaded([
      Task(id: '1',name: 'Task 1',tasktype: Tasktype.personal,isDone: false),
      Task(id: '1',name: 'Task 1',tasktype: Tasktype.personal,isDone: false),
      Task(id: '1',name: 'Task 1',tasktype: Tasktype.personal,isDone: false),
      Task(id: '1',name: 'Task 1',tasktype: Tasktype.personal,isDone: false),
    ]));
  }

  void addTask(Task task) {
    final state = this.state;
    if (state is TaskLoaded) {
      final tasks = state.tasks;
      tasks.add(task);
      emit(TaskLoaded(tasks));
    }
  }

  void removeTask(Task task) {
    final state = this.state;
    if (state is TaskLoaded) {
      final tasks = state.tasks;
      tasks.remove(task);
      emit(TaskLoaded(tasks));
    }
  }

}
