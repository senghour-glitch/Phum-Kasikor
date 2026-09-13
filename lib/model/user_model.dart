class UserModel {
  final int id;
  final String name;
  final String? displayName;
  final String? bio;
  final String? email;
  final String? phone;
  final String? role; // null until choose-role step is completed
  final String? profileImage;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? gender;
  final DateTime? dateOfBirth;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    this.displayName,
    this.bio,
    this.email,
    this.phone,
    this.role,
    this.profileImage,
    this.location,
    this.latitude,
    this.longitude,
    this.gender,
    this.dateOfBirth,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
  });

  bool get hasRole => role != null;
  bool get isFarmer => role == 'farmer';
  bool get isCustomer => role == 'customer';
  bool get isVerified => emailVerifiedAt != null || phoneVerifiedAt != null;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      displayName: json['display_name'],
      bio: json['bio'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      profileImage: json['profile_image'],
      location: json['location'],
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'] != null ? DateTime.tryParse(json['date_of_birth']) : null,
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.tryParse(json['email_verified_at']) : null,
      phoneVerifiedAt: json['phone_verified_at'] != null ? DateTime.tryParse(json['phone_verified_at']) : null,
    );
  }
}