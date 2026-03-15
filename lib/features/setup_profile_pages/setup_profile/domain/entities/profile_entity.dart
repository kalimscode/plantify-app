class ProfileEntity {
  final String fullName;
  final String email;
  final String phone;
  final String gender;
  final String? imagePath;

  const ProfileEntity({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    this.imagePath,
  });

  ProfileEntity copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? gender,
    String? imagePath,
  }) {
    return ProfileEntity(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
