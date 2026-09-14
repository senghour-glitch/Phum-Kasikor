class FarmModel {
  final String id;
  final String name;
  final String image;
  final String location;
  final double rating;
  final int reviews;
  final int followers;
  final double distance;
  final bool organicCertified;

  FarmModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.followers,
    required this.distance,
    this.organicCertified = true,
  });
}