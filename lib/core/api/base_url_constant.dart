//add multiple base urls if needed
enum ApiType{
  base,
  coffee
}

class BaseUrlConstant {
  static const String base='https://jsonplaceholder.typicode.com';
  static const String coffee='https://api.sampleapis.com';

  static String getBaseUrl(ApiType type) {
    switch (type) {
      case ApiType.base:
        return base;
      case ApiType.coffee:
        return coffee;
        

    
    }
  }
  
}
