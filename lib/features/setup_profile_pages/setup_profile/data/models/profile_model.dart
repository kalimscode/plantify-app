import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.fullName,
    required super.email,
    required super.phone,
    required super.gender,
    super.imagePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'imagePath': imagePath,
    };
  }
}
