abstract class ApiConfig {
  String get baseUrl;
  String get environment;
}

class ApiConfigProd implements ApiConfig {
  @override
  String get baseUrl => 'https://backend-flow-chat.onrender.com';
  @override
  String get environment => 'production';
}
