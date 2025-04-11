import '/core/api/base_url_constant.dart';
import '/core/api/error_exception_handler.dart';
import '/core/logger.dart';
import '/services/shared_pref_services.dart';
import 'package:dio/dio.dart';

class DioHelper with ErrorExceptionHandler {
  static final DioHelper _instance = DioHelper._internal();
  factory DioHelper() => _instance;
  DioHelper._internal();

  final Map<ApiType, Dio> _dioMap = {};

  Future<void> init() async {
    final token = SharedPreferencesService.i.token;

    for (var type in ApiType.values) {
      final dio = Dio(
        BaseOptions(
          baseUrl: BaseUrlConstant.getBaseUrl(type),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            logInfo("REQUEST[${options.method}] => PATH: ${options.path}");
            logSuccess("Headers: ${options.headers}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            logInfo(
              "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}",
            );
            logSuccess("Data: ${response.data}");
            return handler.next(response);
          },
          onError: (DioException err, handler) {
            logError(
              "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}",
            );
            logError("Message: ${err.message}");
            return handler.next(err);
          },
        ),
      );

      _dioMap[type] = dio;
    }
  }

  Dio getDio([ApiType type = ApiType.base]) => _dioMap[type]!;

  Future<Response> get(
    String path, {
    ApiType type = ApiType.base,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return getDio(
      type,
    ).get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(
    String path, {
    ApiType type = ApiType.base,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return getDio(type).post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> put(
    String path, {
    ApiType type = ApiType.base,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return getDio(
      type,
    ).put(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> delete(
    String path, {
    ApiType type = ApiType.base,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return getDio(type).delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
