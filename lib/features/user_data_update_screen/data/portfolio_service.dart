import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';

class PortfolioService with ErrorExceptionHandler {
  static Future<PortfolioDataModel?> getPortfolio({
    required String userid,
  }) async {
    try {
      final response = await DioHelper().get(
        '/portfolio/$userid',
        type: ApiType.baseUrl,
      );

      final resultData = response.data['result'];
      final model = PortfolioDataModel.fromJson(resultData);
      return model;
    } catch (e) {
      PortfolioService().handleError(e);
      return null;
    }
  }
}
