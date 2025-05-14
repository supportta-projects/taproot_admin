import 'package:taproot_admin/features/Dashboard_screen/data/dashboard_model.dart';

import '../../../core/api/base_url_constant.dart';
import '../../../core/api/dio_helper.dart';
import '../../../core/api/error_exception_handler.dart';

class DashboardServices with ErrorExceptionHandler {
  static Future<DashboardModel> getDashData() async {
    try {
      final response = await DioHelper().get(
        '/dashboard',
        type: ApiType.baseUrl,
      );
      return DashboardModel.fromJson(response.data);
    } catch (e) {
      throw DashboardServices().handleError(e);
    }
  }
}
