class ToDo {
  String id;
  String todoText;
  bool isCompleted;

  ToDo({required this.id, required this.todoText, this.isCompleted = false});

  // From JSON
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isCompleted': isCompleted,
    };
  }
}
