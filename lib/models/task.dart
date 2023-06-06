enum Tasktype {
  business,
  personal,
}

class Task {
  final int id;
  final String name;
  bool isDone;
  final Tasktype tasktype;

  Task({
    required this.id,
    required this.tasktype,
    required this.name,
    this.isDone = false,
  });

}
