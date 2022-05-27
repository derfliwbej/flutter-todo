class Task {
  final int? id;
  final String title;
  final String details;

  const Task({
    this.id,
    required this.title,
    required this.details,
  });

  Task.fromMap(Map<String, dynamic> res)
    : id = res["id"],
      title = res["title"],
      details = res["details"];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details' : details,
    };
  }
}