import 'package:car_rental/features/auth/domain/entity/user_profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.email,
    required super.username,
  });

  // create the fromJson class for conversion:

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '', // may also return null.. handled
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }
}
