class Task {
  final int id;
  final String title;
  final bool isFavorite;

  Task({required this.isFavorite, required this.id, required this.title});

  Map<String, String> toJson() => <String, String>{
        "id": id.toString(),
        "title": title,
        "isFavorite": isFavorite.toString()
      };

  factory Task.fromJson(Map<String, String> json) {
    return Task(
        id: json["id"] as int,
        title: json["title"].toString(),
        isFavorite: json["isFavorite"] as bool);
  }
}
