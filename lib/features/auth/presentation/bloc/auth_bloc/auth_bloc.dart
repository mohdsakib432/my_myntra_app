import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_myntra_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SharedPreferences prefs;

  AuthBloc(this.loginUseCase, this.registerUseCase, this.prefs)
    : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register); // ✅ FIXED
    on<AutoLoginEvent>(_autoLogin);
    on<LogoutEvent>(_logout);
  }

  // 🔐 LOGIN
  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await loginUseCase(event.email, event.password);
      await prefs.setString('token', token);
      emit(AuthAuthenticated(token));
    } catch (_) {
      emit(AuthError("Login failed ❌"));
    }
  }

  // 🆕 REGISTER
  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await registerUseCase(event.email, event.password);
      await prefs.setString('token', token);
      emit(AuthAuthenticated(token));
    } catch (_) {
      emit(AuthError("Registration failed ❌"));
    }
  }

  // 🔁 AUTO LOGIN
  Future<void> _autoLogin(AutoLoginEvent event, Emitter<AuthState> emit) async {
    final token = prefs.getString('token');
    if (token != null) {
      emit(AuthAuthenticated(token));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // 🚪 LOGOUT
  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    await prefs.remove('token');
    emit(AuthUnauthenticated());
  }
}
