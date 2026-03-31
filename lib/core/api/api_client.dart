import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_routes.dart';

class ApiClient {
  late final Dio dio;

  ApiClient(SharedPreferences prefs) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 🔐 JWT Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = prefs.getString('token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );

    // 🪵 Logger
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
