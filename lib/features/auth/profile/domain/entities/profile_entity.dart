import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String? photo;

  const ProfileEntity({
    required this.firstName,
    required this.lastName,
    this.photo,
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [firstName, lastName, photo];
}
