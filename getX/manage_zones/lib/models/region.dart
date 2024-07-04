class Region {
  final String type;
  final String zoneDtos;
  final int id;
  final bool status;
  final String title;
  final String createdBy;
  final String updatedBy;
  final DateTime createdOn;
  final DateTime updatedOn;

  Region({
    required this.type,
    required this.zoneDtos,
    required this.id,
    required this.status,
    required this.title,
    required this.createdBy,
    required this.updatedBy,
    required this.createdOn,
    required this.updatedOn,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      type: json['type'] as String,
      zoneDtos: json['zoneDtos'] as String,
      id: json['id'] as int,
      status: json['status'] as bool,
      title: json['title'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      updatedOn: DateTime.parse(json['updatedOn'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'zoneDtos': zoneDtos,
      'id': id,
      'status': status,
      'title': title,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdOn': createdOn.toIso8601String(),
      'updatedOn': updatedOn.toIso8601String(),
    };
  }
}
