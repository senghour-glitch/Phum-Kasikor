class ApiConstants {
  // Android emulator only: 10.0.2.2 maps to your host machine's localhost.
  // Swap this for your Railway URL once deployed, or your PC's local IP
  // for physical device testing.
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Auth
  static const String register = 'register';
  static const String verify = 'verify';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String me = 'me';
  static const String firebaseLogin = 'firebase-login';
  static const String firebaseRegister = 'firebase-register';
}