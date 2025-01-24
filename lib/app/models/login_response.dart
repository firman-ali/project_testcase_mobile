// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String token;
  final String citizenName;
  final int roleId;
  final int citizenId;
  final String? profilePictureUrl;

  LoginResponse({
    required this.token,
    required this.citizenName,
    required this.roleId,
    required this.citizenId,
    required this.profilePictureUrl,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        citizenName: json["citizen_name"],
        roleId: json["role_id"],
        citizenId: json["citizen_id"],
        profilePictureUrl: json["profile_picture_url"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "citizen_name": citizenName,
        "role_id": roleId,
        "citizen_id": citizenId,
      };
}
