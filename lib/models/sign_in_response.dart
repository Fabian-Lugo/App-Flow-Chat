import 'dart:convert';

import 'package:flow_chat/models/user.dart';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  final bool validate;
  final UserModel user;
  final String token;

  SignInResponse({
    required this.validate,
    required this.user,
    required this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    validate: json["validate"],
    user: UserModel.fromJson(json["user"]),
    token: (json["token"] ?? json["refreshToken"]) as String,
  );

  Map<String, dynamic> toJson() => {
    "validate": validate,
    "user": user.toJson(),
    "token": token,
  };
}
