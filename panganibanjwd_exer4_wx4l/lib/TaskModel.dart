class Task {
  final int? id;
  final String title;
  final bool completed;

  const Task({
    this.id,
    required this.title,
    required this.completed,
  });

  Task.fromMap(Map<String, dynamic> res)
    : id = res["id"],
      title = res["title"],
      completed = res["completed"];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed' : completed,
    };
  }
}