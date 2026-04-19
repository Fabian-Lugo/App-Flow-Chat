import 'dart:convert';

import 'package:flow_chat/models/user.dart';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  final bool validate;
  final UserModel user;
  final String token;

  SignUpResponse({
    required this.validate,
    required this.user,
    required this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    validate: json["validate"],
    user: UserModel.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "validate": validate,
    "user": user.toJson(),
    "token": token,
  };
}
