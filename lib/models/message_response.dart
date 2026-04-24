import 'dart:convert';

import 'package:flow_chat/models/message.dart';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  final bool validate;
  final int status;
  final String message;
  final String myId;
  final String messagesFrom;
  final List<MessageModel> messages;

  MessageResponse({
    required this.validate,
    required this.status,
    required this.message,
    required this.myId,
    required this.messagesFrom,
    required this.messages,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        validate: json["validate"],
        status: json["status"],
        message: json["message"],
        myId: json["myId"],
        messagesFrom: json["messagesFrom"],
        messages: List<MessageModel>.from(
          json["messages"].map((x) => MessageModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "validate": validate,
    "status": status,
    "message": message,
    "myId": myId,
    "messagesFrom": messagesFrom,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}
