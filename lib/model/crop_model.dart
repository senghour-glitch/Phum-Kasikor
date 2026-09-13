class CropModel {
  final String id;
  final String name;
  final String variety;
  final String? imageUrl;
  final String description;
  final String season;

  CropModel({
    required this.id,
    required this.name,
    required this.variety,
    this.imageUrl,
    required this.description,
    required this.season,
  });

  CropModel copyWith({
    String? id,
    String? name,
    String? variety,
    String? imageUrl,
    String? description,
    String? season,
  }) {
    return CropModel(
      id: id ?? this.id,
      name: name ?? this.name,
      variety: variety ?? this.variety,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      season: season ?? this.season,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'variety': variety,
    'image_url': imageUrl,
    'description': description,
    'season': season,
  };

  factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    variety: json['variety'] as String? ?? '',
    imageUrl: json['image_url'] as String?,
    description: json['description'] as String? ?? '',
    season: json['season'] as String? ?? '',
  );
}