class User {
  final String fullName;
  final String userId;
  final String phone;
  final String whatsapp;
  final String email;
  final String website;
   bool isPremium;

  User({
    required this.fullName,
    required this.userId,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.website,
    required this.isPremium,
  });
}
