class CreatedBy {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] as int,
      creditId: json['credit_id'] as String,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      gender: json['gender'] as int,
      profilePath: json['profile_path'] as String?,
    );
  }
}