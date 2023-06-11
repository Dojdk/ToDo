import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/db_helper.dart';
import '../../models/type.dart';
import '../task/task_cubit.dart';


part 'type_state.dart';

class TypeCubit extends Cubit<TypeState> {
  final taskCubit = TaskCubit();
  TypeCubit() : super(TypeInitial());

  final dbHelper = DatabaseHelper.instance;

  void loadTypes() async {
    emit(TypeLoading());
    try {
      final types = await dbHelper.getAllTypes();
      emit(TypeLoaded(types));
    } catch (e) {
      emit(TypeError());
    }
  }

  void addType(TaskType type) {
    final currentState = state;
    if (currentState is TypeLoaded) {
      try {
        final List<TaskType> updatedTypes = [...currentState.types, type];
        dbHelper.insertType(type);
        emit(TypeLoaded(updatedTypes));
      } catch (e) {
        emit(TypeError());
      }
    }
  }

  void removeType(TaskType type) {
    final currentState = state;
    if (currentState is TypeLoaded) {
      try {
        dbHelper.deleteType(type.id);
        final List<TaskType> types = [...currentState.types];
        types.remove(type);
        emit(TypeLoaded(types));
      } catch (e) {
        emit(TypeError());
      }
    }
  }

  void updateType(TaskType type) {
    final currentState = state;
    if (currentState is TypeLoaded) {
      try {
        dbHelper.updateType(type);
        final List<TaskType> types = [...currentState.types];
        final index = types.indexWhere((element) => element.id == type.id);
        types[index] = type;
        emit(TypeLoaded(types));
      } catch (e) {
        emit(TypeError());
      }
    }
  }

  get getTypes {
    final currentState = state;
    if (currentState is TypeLoaded) {
      return currentState.types;
    }
  }
}
