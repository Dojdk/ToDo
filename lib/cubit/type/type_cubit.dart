import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/type.dart';
import '../../theme/colors.dart';

part 'type_state.dart';

class TypeCubit extends Cubit<TypeState> {
  TypeCubit() : super(TypeInitial());

  void loadTypes() async {
    emit(TypeLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(
      TypeLoaded(
        [
          TaskType(name: 'Personal', color: blue),
          TaskType(name: 'Business', color: pink),
          TaskType(name: 'Shopping', color: Colors.deepPurple),
          TaskType(name: 'Party', color: Colors.green),
        ],
      ),
    );
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
