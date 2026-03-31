import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final SharedPreferences prefs;

  AuthRepositoryImpl(this.dio, this.prefs);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login', // 🔥 change if needed
        data: {"email": email, "password": password},
      );

      final token = response.data['token'];

      // ✅ save token
      await prefs.setString('token', token);

      return token;
    } catch (e) {
      throw Exception("Login failed");
    }
  }

  @override
  Future<String> register(String email, String password) async {
    final response = await dio.post(
      '/register',
      data: {"email": email, "password": password},
    );

    return response.data['token']; // or handle response
  }
}
