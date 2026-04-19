abstract class ApiConfig {
  String get baseUrl;
  String get environment;
}

class ApiConfigProd implements ApiConfig {
  @override
  String get baseUrl =>
      'https://juliet-unspattered-nonobviously.ngrok-free.dev';
  @override
  String get environment => 'production';
}
