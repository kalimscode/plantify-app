import 'package:flutter/foundation.dart';
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
    debugPrint('🔍 ProfileModel.fromJson keys: ${json.keys.toList()}');

    final name = _firstNonEmpty([
      json['fullName'],
      json['full_name'],
      json['name'],
      json['username'],
      json['displayName'],
      json['display_name'],
    ]);

    final phone = _firstNonEmpty([
      json['phone'],
      json['phoneNumber'],
      json['phone_number'],
      json['mobile'],
    ]);

    final gender = _firstNonEmpty([
      json['gender'],
      json['sex'],
    ]);

    final model = ProfileModel(
      fullName: name,
      email: (json['email'] as String?)?.trim() ?? '',
      phone: phone,
      gender: gender,
      imagePath: (json['imagePath'] as String?) ??
          (json['image'] as String?) ??
          (json['avatar'] as String?) ??
          (json['profilePicture'] as String?),
    );

    debugPrint('✅ ProfileModel built: name="${model.fullName}" email="${model.email}" phone="${model.phone}"');
    return model;
  }

  static String _firstNonEmpty(List<dynamic> values) {
    for (final v in values) {
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    return '';
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'gender': gender,
    'imagePath': imagePath,
  };
}