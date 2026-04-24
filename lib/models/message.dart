class MessageModel {
  final String sender;
  final String receiver;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
