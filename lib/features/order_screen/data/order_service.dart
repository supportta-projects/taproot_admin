import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_paginated_model.dart';

class OrderService with ErrorExceptionHandler {
  static Future<OrderResponse> getAllOrder({int page = 1}) async {
    try {
      final response = await DioHelper().get(
        '/order/all',
        type: ApiType.baseUrl,
        queryParameters: {'page': page},
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

      logInfo('API Response: ${response.data}');

      return OrderDetailsResponse.fromJson(response.data);
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }

  static Future<String> getOrderId() async {
    try {
      final response = await DioHelper().get(
        '/order/id',
        type: ApiType.baseUrl,
      );
      return response.data['result'] as String;
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

  static Future<ProductResponse> fetchProduct(String? searchQuery) async {
    try {
      final response = await DioHelper().get(
        '/product',
        type: ApiType.baseUrl,
        queryParameters: {
          'limit': 4,
          // 'page': page,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
        },
      );
      final data = response.data;
      return ProductResponse.fromJson(data);
    } catch (e) {
      throw OrderService().handleError(e); // Handle the error properly
    }
  }

  static Future<OrderDetailsResponse> editOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await DioHelper().patch(
        '/order/order-details/$orderId',
        type: ApiType.baseUrl,
        data: data,
      );
      return OrderDetailsResponse.fromJson(response.data);
    } catch (e) {
      throw OrderService().handleError(e); // Handle the error properly
    }
  }
}
