import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/features/users_screen/data/user_paginated_model.dart';

class UserService with ErrorExceptionHandler {
  static Future<PaginatedUserResponse> fetchUser(int page) async {
    try {
      final response = await DioHelper().get(
        '/user',
        type: ApiType.baseUrl,
        queryParameters: {'page': page},
      );
      final data = response.data;
      return PaginatedUserResponse.fromJson(data);
      
    } catch (e) {
      throw UserService().handleError(e);
    }
  }
}
