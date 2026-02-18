class ApiRoutes {
  // Base
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Auth
  static const String login = '$baseUrl/auth/login';

  // Products
  static const String products = '$baseUrl/products';
  // static String productById(int id) => '$baseUrl/products/$id';

  // Search
  static String searchProduct(String query) =>
      '$baseUrl/products/search?q=$query';
}
