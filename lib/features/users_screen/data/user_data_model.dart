class User {
  final String fullName;
  final String userId;
  final String phone;
  final String whatsapp;
  final String email;
  final String website;
  final String id;
  bool isPremium;

  User({
    required this.fullName,
    required this.userId,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.website,
    required this.id,
    required this.isPremium,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['name'] ?? '',
      userId: json['code'] ?? '',
      phone: json['phoneNumber'] ?? '',
      whatsapp: json['whatsappNumber'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      id: json['_id'] ?? '',
      isPremium: json['isPremium'] ?? false,
    );
  }
}
