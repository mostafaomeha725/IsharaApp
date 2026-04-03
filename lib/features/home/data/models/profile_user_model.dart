import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';

class ProfileUserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final bool isVerified;

  const ProfileUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.isVerified,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString() ?? '',
      isVerified: json['is_verified'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'is_verified': isVerified,
    };
  }

  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      email: email,
      gender: gender,
      dateOfBirth: dateOfBirth,
      isVerified: isVerified,
    );
  }
}
