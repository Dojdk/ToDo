import 'package:bloc/bloc.dart';
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
      // await dbHelper.insertType(TaskType(id: 1, name: 'Personal', color: blue));
      // await dbHelper.insertType(TaskType(id: 2, name: 'Business', color: pink));
      // await dbHelper.insertType(
      //     TaskType(id: 3, name: 'Shopping', color: Colors.deepPurple));
      // await dbHelper
      //     .insertType(TaskType(id: 4, name: 'Party', color: Colors.green));
      final types = await dbHelper.getAllTypes();
      emit(TypeLoaded(types));
    } catch (e) {
      print(e);
      emit(TypeError());
    }
  }

  void addType(TaskType type) {
    final currentState = state;
    if (currentState is TypeLoaded) {
      final List<TaskType> updatedTypes = [...currentState.types, type];
      emit(TypeLoaded(updatedTypes));
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
