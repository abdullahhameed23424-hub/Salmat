import 'package:my_project_new/modules/auth/models/user.dart';

class ProfileResponse {
  final User user;

  ProfileResponse({required this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      user: User.fromJson(json),
    );
  }
}
