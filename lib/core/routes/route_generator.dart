import 'package:flutter/material.dart';
import 'package:my_myntra_app/features/auth/presentation/pages/homepage.dart';
import 'package:my_myntra_app/features/auth/presentation/pages/loginpage.dart';
import 'package:my_myntra_app/features/auth/presentation/pages/product_page.dart';
import 'package:my_myntra_app/features/auth/presentation/pages/splashscreen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const Homepage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case AppRoutes.product:
        return MaterialPageRoute(builder: (_) => ProductPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("404 - Page not found", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
