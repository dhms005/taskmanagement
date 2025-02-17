class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date; // Date field
  final int priority; // Priority field

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
    required this.priority,
  });

  // Convert Task object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0, // Store as integer (0 or 1)
      'date': date.toIso8601String(), // Convert DateTime to string for storage
      'priority': priority,
    };
  }

  // Convert Map to Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1, // Convert integer back to bool
      date: DateTime.parse(map['date']), // Convert string back to DateTime
      priority: map['priority'],
    );
  }

  // Optionally, add a copyWith method for easier updating of task attributes
  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
    int? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      priority: priority ?? this.priority,
    );
  }
}
