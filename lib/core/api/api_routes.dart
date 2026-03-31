class ApiRoutes {
  static const bool isProduction = false;

  static String get baseUrl {
    if (isProduction) {
      return 'https://yourapi.com';
    }

    // 🔥 Use same IP for all local testing
    return 'http://10.174.111.19:3000';
  }

  // Auth
  static String get login => '$baseUrl/login';

  // Products
  static String get products => '$baseUrl/products';

  // Search
  static String searchProduct(String query) =>
      '$baseUrl/products/search?q=$query';
}
