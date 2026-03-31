import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_myntra_app/core/routes/app_routes.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/auth_bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scale;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  bool _animationDone = false;
  AuthState? _lastState;

  @override
  void initState() {
    super.initState();

    // ✅ INIT FIRST
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scale = Tween(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slide = Tween(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // ✅ ONLY ONE LISTENER
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationDone = true;

        if (_lastState != null) {
          _handleNavigation(_lastState!);
        }
      }
    });

    _controller.forward();

    // ✅ Trigger auth ONLY ONCE
    context.read<AuthBloc>().add(AutoLoginEvent());
  }

  void _handleNavigation(AuthState state) {
    if (!_animationDone) return;

    if (state is AuthAuthenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (state is AuthUnauthenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          _lastState = state;
          _handleNavigation(state); // ✅ ONLY THIS
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF3F6C), Color(0xFFFF6F61)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_bag, size: 90, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        "Myntra",
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
