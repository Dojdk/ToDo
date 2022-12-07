import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<TaskLoadEvent>((event, emit) {});

    on<AddTask>((event, emit) {
      final state = this.state;
      final allTasks = state.allTasks;

      emit(
        TaskState(
          allTasks: List.from(state.allTasks)
            ..insert(
                0,
                Task(
                    id: '${allTasks.length + 1}',
                    tasktype: event.tasktype,
                    name: event.taskname)),
        ),
      );
    });

    on<TaskUpdate>((event, emit) {
      final state = this.state;
      final task = event.task;
      final index = state.allTasks.indexOf(task);
      List<Task> allTasks = List.from(state.allTasks)..remove(task);
      task.isDone == false
          ? allTasks.insert(index, task.copyWith(isDone: true))
          : allTasks.insert(index, task.copyWith(isDone: false));
      emit(
        TaskState(
          allTasks: allTasks,
        ),
      );
    });

    on<DeleteTask>(
      (event, emit) {
        final state = this.state;
        final task = event.task;
        List<Task> allTasks = List.from(state.allTasks)..remove(task);
        emit(
          TaskState(
            allTasks: allTasks,
          ),
        );
      },
    );

    on<UndoDelteTask>(
      (event, emit) {
        final state = this.state;
        final task = event.task;
        final index = event.index;
        List<Task> allTasks = List.from(state.allTasks)..insert(index, task);
        emit(
          TaskState(
            allTasks: allTasks,
          ),
        );
      },
    );
  }
}
