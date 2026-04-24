import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flow_chat/api/api_config.dart';
import 'package:flow_chat/models/message.dart';
import 'package:flow_chat/api/api_endpoints.dart';
import 'package:flow_chat/models/message_response.dart';
import 'package:flow_chat/features/auth/services/auth.dart';

class MessagesService with ChangeNotifier {
  final ApiConfig config = ApiConfigProd();

  Future<List<MessageModel>> getMessagesByUser(String userId) async {
    final url = Uri.parse(
      '${config.baseUrl}${ApiEndpoints.getMessagesByUser}$userId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? 'no-token',
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      final json = jsonDecode(response.body);
      final messageResponse = MessageResponse.fromJson(json);
      return messageResponse.messages;
    } catch (_) {
      return [];
    }
  }
}
