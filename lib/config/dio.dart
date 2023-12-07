import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final options = BaseOptions(
  baseUrl: 'http://192.168.1.2:8000/api',
  connectTimeout: const Duration(seconds: 60),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
  receiveTimeout: const Duration(seconds: 60),
);
final dio = Dio(options);

class AuthInterceptor {
  static init() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
