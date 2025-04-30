import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class PaginatedUserResponse {
  final List<User> users;
  final int totalPages;
  final int totalCount;

  PaginatedUserResponse({
    required this.users,
    required this.totalPages,
    required this.totalCount,
  });

  factory PaginatedUserResponse.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    return PaginatedUserResponse(
      users: results.map((e) => User.fromJson(e)).toList(),
      totalPages: json['totalPages'] ?? 1,
      totalCount: json['totalCount'] ?? results.length,
    );
  }
}
