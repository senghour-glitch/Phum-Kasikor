class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String image;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.image,
  });

  factory CustomerModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return CustomerModel(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'image': image,
    };
  }
}