import 'dart:convert';

import 'package:flow_chat/models/user.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  final bool validate;
  final List<UserModel> users;

  UserResponse({required this.validate, required this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    validate: json["validate"],
    users: List<UserModel>.from(
      json["users"].map((x) => UserModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "validate": validate,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}
