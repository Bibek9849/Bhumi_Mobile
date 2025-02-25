class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.1.68:3000/api/";
//192.168.1.68:
  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";
  static const String updateUser = "users/updateUser/"; // ✅ Fixed URL
  static const String getMe = "users/getMe"; // ✅ Correct API Endpoint

  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String imageUrl = "http://192.168.1.68:3000/uploads/";
  static const String uploadImage = "/users/uploadImage";
  // ====================== Product Routes ======================
  static const String getAllProduct = "product/getAllProduct";
  static const String getAllCategory = "category/";
}
