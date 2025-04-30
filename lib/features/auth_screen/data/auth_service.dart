import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/services/shared_pref_services.dart';

class AuthService with ErrorExceptionHandler {
  static Future<void> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper().patch(
        '/admin/login',
        data: {'email': email, 'password': password},
        type: ApiType.baseUrl,
      );
      String token = response.data['result']['token'];
      await SharedPreferencesService.i.setValue(key: 'token', value: token);
    } catch (e) {
      throw AuthService().handleError(e);
    }
  }
}
