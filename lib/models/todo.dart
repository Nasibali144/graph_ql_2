class Todo {
  int id;
  bool isCompleted;
  DateTime createdAt;
  bool isPublic;
  String title;
  String userId;

  Todo({
    required this.id,
    required this.isCompleted,
    required this.createdAt,
    required this.isPublic,
    required this.title,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, Object?> json) {
    return Todo(
      id: json['id'] as int,
      isCompleted: json['is_completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      isPublic: json['is_public'] as bool,
      title: json['title'] as String,
      userId: json['user_id'] as String,
    );
  }
}
