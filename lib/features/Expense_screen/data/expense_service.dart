import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/Expense_screen/data/expense_model.dart';

class ExpenseService {
  static Future<ExpenseResponse> getExpense(int page) async {
    try {
      final response = await DioHelper().get(
        '/expense',
        type: ApiType.baseUrl,
        queryParameters: {'page': page, 'limit': 5},
      );

      if (response.statusCode == 200) {
        return ExpenseResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load expenses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching expenses: $e');
    }
  }

 static Future<ExpenseResponse> addExpense({
    required String category,
    required String name,
    required double amount,
    required String description,
    required DateTime date,
  }) async {
    try {
      final data = {
        'category': category,
        'name': name,
        'amount': amount,
        'description': description,
        'date': date.toIso8601String(),
      };

      logInfo('Adding expense with data: $data');

      final response = await DioHelper().post(
        '/expense',
        type: ApiType.baseUrl,
        data: data,
      );

      logInfo('Add expense response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ExpenseResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to add expense: ${response.statusMessage}');
      }
    } catch (e) {
      logError('Error adding expense: $e');
      throw Exception('Failed to add expense: $e');
    }
  }

}
