import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/task.dart';
import '../../helper/db_helper.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  final dbHelper = DatabaseHelper.instance;

  void loadTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await dbHelper.getAllTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError());
    }
  }

  void addTask(Task task) async{
    final state = this.state;
    if (state is TaskLoaded) {
      try {
       await dbHelper.insertTask(task);
        final tasks = state.tasks;
        tasks.add(task);
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError());
      }
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

  void removeTask(Task task) async{
    final state = this.state;
    if (state is TaskLoaded) {
      try{
      await dbHelper.deleteTask(task.id);
      final tasks = state.tasks;
      tasks.remove(task);
      emit(TaskLoaded(tasks));
      }catch(e){
        emit(TaskError());
      }
    }
  }
}
