
class Task {
  final int id;
  final String name;
  bool isDone;
  final int typeId;

  Task({
    required this.id,
    required this.typeId,
    required this.name,
    this.isDone = false,
  });

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone ? 1 : 0,
      'typeId': typeId,
    };
  }
}
