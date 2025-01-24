import 'dart:convert';

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  final String nik;
  final String password;

  LoginRequest({
    required this.nik,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "password": password,
      };
}
