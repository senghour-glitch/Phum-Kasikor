import 'user_model.dart';

class LoginRequest {
  const LoginRequest({required this.phone, required this.password});
  final String phone, password;
  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}

class SignUpRequest {
  const SignUpRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.role,
    this.email,
  });
  final String name, phone, password;
  final UserRole role;
  final String? email;
  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'password': password,
    'role': role.name,
    'email': email,
  };
}

class OtpRequest {
  const OtpRequest({required this.phone, required this.code});
  final String phone, code;
  Map<String, dynamic> toJson() => {'phone': phone, 'code': code};
}

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.user,
    this.refreshToken,
    this.expiresAt,
  });
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final UserModel user;
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  factory AuthSession.fromJson(Map<String, dynamic> json) => AuthSession(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String?,
    expiresAt: json['expiresAt'] == null
        ? null
        : DateTime.parse(json['expiresAt'] as String),
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt?.toIso8601String(),
    'user': user.toJson(),
  };
}
