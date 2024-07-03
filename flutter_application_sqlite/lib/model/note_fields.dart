class NoteFields {
  static const List<String> values = [
    id,
    number,
    title,
    content,
    isFavorite,
    createdTime,
  ];

  static const String tableName = 'notes';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String title = 'title';
  static const String number = 'number';
  static const String content = 'content';
  static const String isFavorite = 'is_favorite';
  static const String createdTime = 'created_time';
}
