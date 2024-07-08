class Task {
  final int id;
  final String title;

  Task({required this.id, required this.title});

  Map<String, String> toJson() =>
      <String, String>{"id": id.toString(), "title": title};

  factory Task.fromJson(Map<String, String> json) {
    return Task(
      id: json["id"] as int,
      title: json["title"].toString(),
    );
  }
}
