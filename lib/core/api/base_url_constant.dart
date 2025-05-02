//add multiple base urls if needed
enum ApiType { base, coffee, baseUrl }

class BaseUrlConstant {
  static const String base = 'https://jsonplaceholder.typicode.com';
  static const String coffee = 'https://api.sampleapis.com';
  static const String baseUrl = 'http://213.210.36.7:5000/api/v1';

  static String getBaseUrl(ApiType type) {
    switch (type) {
      case ApiType.base:
        return base;
      case ApiType.coffee:
        return coffee;
      case ApiType.baseUrl:
        return baseUrl;
    }
  }
}
