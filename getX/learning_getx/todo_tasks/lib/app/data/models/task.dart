class Task {
  int id;
  String title;
  bool isFavorite;

  Task({required this.id, required this.title, required this.isFavorite});

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"title": title, "isFavorite": isFavorite ? 1 : 0};

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"] as int,
      title: json["title"] as String,
      isFavorite: json["isFavorite"] == 1,
    );
  }
}
