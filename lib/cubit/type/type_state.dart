part of 'type_cubit.dart';

abstract class TypeState {}

class TypeInitial extends TypeState {}

class TypeLoading extends TypeState {}

class TypeLoaded extends TypeState {
  final List<TaskType> types;

  TypeLoaded(this.types);
}
