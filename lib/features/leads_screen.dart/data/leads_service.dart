import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/leads_screen.dart/data/leads_model.dart';

class LeadsService {
  static Future<LeadsResponse?> getLeads() async {
    try {
      final response = await DioHelper().get('/lead', type: ApiType.baseUrl);

      if (response.statusCode == 200) {
        return LeadsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load leads: ${response.statusCode}');
      }
    } catch (e) {
      logError('Error fetching leads: $e');
      return null;
    }
  }
}
