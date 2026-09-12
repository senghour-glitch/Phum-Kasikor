enum UserRole { farmer, customer }

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    this.email,
    this.imageUrl,
  });
  final String id, name, phone;
  final UserRole role;
  final String? email, imageUrl;
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    role: UserRole.values.byName(json['role'] as String),
    email: json['email'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'role': role.name,
    'email': email,
    'imageUrl': imageUrl,
  };
}
