import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/order_screen/data/order_detail_add.model.dart';
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_refund_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_paginated_model.dart';

class OrderService with ErrorExceptionHandler {
  static Future<OrderResponse> getAllOrder({
    int page = 1,
    String? search,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final response = await DioHelper().get(
        '/order/all',
        type: ApiType.baseUrl,
        queryParameters: queryParameters,
      );
      return OrderResponse.fromJson(response.data);
    } catch (e) {
      throw OrderService().handleError(e);
    }
  }
  // static Future<OrderResponse> getAllOrder({int page = 1,}) async {
  //   try {
  //     final response = await DioHelper().get(
  //       '/order/all',
  //       type: ApiType.baseUrl,
  //       queryParameters: {'page': page},
  //     );
  //     return OrderResponse.fromJson(response.data);
  //   } catch (e) {
  //     throw OrderService().handleError(e);
  //   }
  // }
  // static Future<OrderDetailsResponse> getOrderDetails({
  //     required String orderId,
  //   }) async {
  //     try {
  //       // Validate orderId format before making the request
  //       if (orderId.isEmpty || orderId.length != 24) {
  //         throw Exception('Invalid order ID format');
  //       }

  //       final response = await DioHelper().get(
  //         '/order/order-details/$orderId',
  //         type: ApiType.baseUrl,
  //       );

  //       logInfo('API Response: ${response.data}');

  //       // Check if response.data is not null and has the expected structure
  //       if (response.data == null) {
  //         throw Exception('Empty response received');
  //       }

  //       final orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);

  //       // Validate the response
  //       if (!orderDetailsResponse.success) {
  //         throw Exception(
  //           orderDetailsResponse.message ?? 'Failed to fetch order details',
  //         );
  //       }

  //       return orderDetailsResponse;
  //     } catch (e) {
  //       logError('OrderService error: $e');
  //       throw OrderService().handleError(e);
  //     }
  //   }

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

  static Future<OrderPostModel> createOrder({
    required String userId,
    required OrderPostModel orderData,
  }) async {
    try {
      final response = await DioHelper().post(
        '/order/$userId',
        type: ApiType.baseUrl,
        data: orderData.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return orderData;
      } else {
        throw Exception(
          'Failed to create order. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      logError('Error creating order: $e');
      throw OrderService().handleError(e);
    }
  }

  static Future<bool> checkPortfolio({required String userid}) async {
    try {
      final response = await DioHelper().get(
        '/portfolio/$userid',
        type: ApiType.baseUrl,
      );

      // Check both status code and response data
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      logError('Portfolio check error: $e');
      // Any error (including 404) means no portfolio
      return false;
    }
  }

  static Future<RefundResponse> cancelOrder({
    required String orderId,
    required int refundPercentage,
  }) async {
    try {
      final response = await DioHelper().patch(
        '/order/cancel-order/$orderId',
        type: ApiType.baseUrl,
        data: {'refundPercentage': refundPercentage},
      );

      return RefundResponse.fromJson(response.data);
     
    } catch (e) {
      logError('Error canceling order: $e');
      throw OrderService().handleError(e);
    }
  }
}
