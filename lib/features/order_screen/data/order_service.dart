import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_paginated_model.dart';

class OrderService with ErrorExceptionHandler {
  static Future<OrderResponse> getAllOrder() async {
    try {
      final response = await DioHelper().get(
        '/order/all',
        type: ApiType.baseUrl,
      );
      return OrderResponse.fromJson(response.data);
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }

  static Future<OrderDetailsResponse> getOrderDetails({
    required String orderId,
  }) async {
    try {
      final response = await DioHelper().get(
        '/order/order-details/$orderId',
        type: ApiType.baseUrl,
      );
      return OrderDetailsResponse.fromJson(response.data);
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }

  static Future getOrderId() async {
    try {
      final response = await DioHelper().get(
        '/order/id',
        type: ApiType.baseUrl,
      );
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }

  static Future<PaginatedUserResponse> fetchUser(
    // int page,
    String? searchQuery,
  ) async {
    try {
      final response = await DioHelper().get(
        '/user',
        type: ApiType.baseUrl,
        queryParameters: {
          'limit': 4,
          // 'page': page,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
        },
      );
      final data = response.data;
      return PaginatedUserResponse.fromJson(data);
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }
}
