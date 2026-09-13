class FarmModel {
  final String id;
  final String name;
  final String ownerId;
  final String? imageUrl;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? description;

  FarmModel({
    required this.id,
    required this.name,
    required this.ownerId,
    this.imageUrl,
    required this.address,
    this.latitude,
    this.longitude,
    this.description,
  });

  FarmModel copyWith({
    String? id,
    String? name,
    String? ownerId,
    String? imageUrl,
    String? address,
    double? latitude,
    double? longitude,
    String? description,
  }) {
    return FarmModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'owner_id': ownerId,
    'image_url': imageUrl,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'description': description,
  };

  factory FarmModel.fromJson(Map<String, dynamic> json) => FarmModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    ownerId: json['owner_id'] as String? ?? '',
    imageUrl: json['image_url'] as String?,
    address: json['address'] as String? ?? '',
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    description: json['description'] as String?,
  );
}