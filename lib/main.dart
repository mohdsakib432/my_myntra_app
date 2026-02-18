import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_myntra_app/core/routes/app_routes.dart';
import 'package:my_myntra_app/core/routes/route_generator.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/theme/theme_bloc.dart';
import 'package:my_myntra_app/features/auth/presentation/bloc/product/theme/theme_state.dart';
import 'package:my_myntra_app/injection_container.dart' as di;
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // 🔥 REQUIRED

  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
