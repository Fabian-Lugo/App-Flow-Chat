import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flow_chat/models/user.dart';
import 'package:flow_chat/api/api_config.dart';
import 'package:flow_chat/api/auth_endpoints.dart';
import 'package:flow_chat/models/sign_in_response.dart';
import 'package:flow_chat/models/sign_up_response.dart';

enum SignInResult { success, invalidCredentials, failure }

enum SignUpResult { success, emailAlreadyRegistered, failure }

class AuthService with ChangeNotifier {
  UserModel? user;

  final _storage = FlutterSecureStorage();
  final ApiConfig config = ApiConfigProd();

  static final _sharedStorage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return _sharedStorage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await _sharedStorage.delete(key: 'token');
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<bool?> isSignedIn() async {
    final url = Uri.parse('${config.baseUrl}${AuthEndpoints.refreshToken}');
    final token = await getToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token as String,
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      final json = jsonDecode(response.body);
      final signInResponse = SignInResponse.fromJson(json);
      await _saveToken(signInResponse.token);
      user = signInResponse.user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<SignInResult> signIn(String email, String password) async {
    final payload = {'email': email, 'password': password};
    final url = Uri.parse('${config.baseUrl}${AuthEndpoints.signIn}');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 400 || response.statusCode == 401) {
        return SignInResult.invalidCredentials;
      }

      if (response.statusCode != 200) {
        return SignInResult.failure;
      }

      final json = jsonDecode(response.body);
      final signInResponse = SignInResponse.fromJson(json);
      await _saveToken(signInResponse.token);
      user = signInResponse.user;
      notifyListeners();
      return SignInResult.success;
    } catch (_) {
      return SignInResult.failure;
    }
  }

  Future<SignUpResult> signUp(
    String name,
    String email,
    String password,
  ) async {
    final payload = {'name': name, 'email': email, 'password': password};
    final url = Uri.parse('${config.baseUrl}${AuthEndpoints.signUp}');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 400) {
        return SignUpResult.emailAlreadyRegistered;
      }

      if (response.statusCode != 200) {
        return SignUpResult.failure;
      }

      final json = jsonDecode(response.body);
      final signUpResponse = SignUpResponse.fromJson(json);
      await _saveToken(signUpResponse.token);
      user = signUpResponse.user;
      notifyListeners();
      return SignUpResult.success;
    } catch (_) {
      return SignUpResult.failure;
    }
  }
}
