class Inspection {
  final int id;
  final String code;
  final int odometer;
  final String result;
  final String description;
  final String photo;
  final String photoContentType;
  final String completed;

  Inspection({
    required this.id,
    required this.code,
    required this.odometer,
    required this.result,
    required this.description,
    required this.photo,
    required this.photoContentType,
    required this.completed,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      odometer: (json['odometer'] as num?)?.toInt() ?? 0,
      result: json['result'] as String? ?? '',
      description: json['description'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      photoContentType: json['photoContentType'] as String? ?? '',
      completed: json['completed'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'odometer': odometer,
      'result': result,
      'description': description,
      'photo': photo,
      'photoContentType': photoContentType,
      'completed': completed,
    };
  }
}
