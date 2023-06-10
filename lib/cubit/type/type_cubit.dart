import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
import '../../helper/db_helper.dart';
import '../../models/type.dart';
// import '../../theme/colors.dart';

part 'type_state.dart';

class TypeCubit extends Cubit<TypeState> {
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
      final List<TaskType> updatedTypes = [...currentState.types];
      updatedTypes.remove(type);
      emit(TypeLoaded(updatedTypes));
    }
  }

  get getTypes {
    final currentState = state;
    if (currentState is TypeLoaded) {
      return currentState.types;
    }
  }
}
