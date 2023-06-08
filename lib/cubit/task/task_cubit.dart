import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void loadTasks() async {
    emit(TaskLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(TaskLoaded([]));
  }

  void addTask(Task task) {
    final state = this.state;
    if (state is TaskLoaded) {
      final tasks = state.tasks;
      tasks.add(task);
      emit(TaskLoaded(tasks));
    }
  }

  void updateTask(Task task) {
    final state = this.state;
    if (state is TaskLoaded) {
      final tasks = state.tasks;
      final index = tasks.indexWhere((element) => element.id == task.id);
      tasks[index] = task;
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
