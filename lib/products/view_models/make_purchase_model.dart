class PurchaseModel {
  String name;
  String address;
  double latitude;
  double longitude;
  String? avatarImage;

  PurchaseModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.avatarImage,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      avatarImage: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'photo': avatarImage,
      };
}
