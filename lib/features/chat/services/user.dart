import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flow_chat/api/api_config.dart';
import 'package:flow_chat/api/api_endpoints.dart';
import 'package:flow_chat/features/auth/services/auth.dart';
import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/models/user_response.dart';

class UserService {
  final ApiConfig config = ApiConfigProd();

  Future<List<UserModel>> getUsers() async {
    final url = Uri.parse('${config.baseUrl}${ApiEndpoints.getUser}');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? 'no-token',
        },
      );

      final userResponse = UserResponse.fromJson(jsonDecode(response.body));
      return userResponse.users;
    } catch (_) {
      return [];
    }
  }
}
