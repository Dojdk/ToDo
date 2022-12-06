import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskLoadEvent>((event, emit) {});
    on<AddTask>((event, emit) {
      if(state is TaskLoaded){
        
      }
    });
    on<TaskIsDone>((event, emit) {});
    on<TaskIsNotDone>((event, emit) {});
    on<DeleteTask>((event, emit) {});
  }
}
