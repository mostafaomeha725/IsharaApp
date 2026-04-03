import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  const ProfileUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.isVerified,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final bool isVerified;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        fullName,
        email,
        gender,
        dateOfBirth,
        isVerified,
      ];
}
