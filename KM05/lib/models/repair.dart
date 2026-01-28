class Repair {
  final int id;
  final String description;

  Repair({
    required this.id, 
    required this.description
  });

  factory Repair.fromJson(Map<String, dynamic> json) {
    return Repair(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
    );
  }
}