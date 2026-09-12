class CustomerModel {
  const CustomerModel({
    required this.userId,
    this.defaultAddress,
    this.favoriteFarmIds = const [],
  });
  final String userId;
  final String? defaultAddress;
  final List<String> favoriteFarmIds;
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    userId: json['userId'] as String,
    defaultAddress: json['defaultAddress'] as String?,
    favoriteFarmIds: List<String>.from(
      json['favoriteFarmIds'] as List? ?? const [],
    ),
  );
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'defaultAddress': defaultAddress,
    'favoriteFarmIds': favoriteFarmIds,
  };
}
