import 'package:dio/dio.dart';
import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
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

      final model = PortfolioDataModel.fromJson(response.data);
      return model;
    } catch (e) {
      throw PortfolioService().handleError(e);
    }
  }

  static Future<Map<String, dynamic>?> postPortfolio({
    required String userid,
    required Map<String, dynamic> portfolioData,
  }) async {
    int retries = 3;
    while (retries > 0) {
      try {
        final response = await DioHelper().post(
          '/portfolio/$userid',
          type: ApiType.baseUrl,
          data: portfolioData,
        );

        if (response.statusCode == 404) {
          throw Exception('Portfolio not found for user ID: $userid');
        } else if (response.statusCode == 400) {
          throw Exception('Bad request: Invalid portfolio data');
        } else if (response.statusCode == 500) {
          throw Exception('Server error. Please try again later.');
        }

        if (response.data != null) {
          return response.data;
        } else {
          throw Exception("Response data is null");
        }
      } catch (e) {
        retries--;
        if (retries == 0) {
          logError('Error: $e');
          throw PortfolioService()
              .handleError(e)
              .copyWith(message: 'Post portfolio failed: $e');
        }
      }
    }
    return null;
  }

  static Future<Map<String, dynamic>> getDatafromPincode({
    required int pinCode,
  }) async {
    try {
      Response response = await DioHelper().get(
        '/pincode/$pinCode',
        type: ApiType.pincodeUrl,
      );
      return response.data;
    } catch (e) {
      throw PortfolioService().handleError(e);
    }
  }
}



// import 'package:taproot_admin/core/api/base_url_constant.dart';
// import 'package:taproot_admin/core/api/dio_helper.dart';
// import 'package:taproot_admin/core/api/error_exception_handler.dart';
// import 'package:taproot_admin/core/logger.dart';
// import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';

// class PortfolioService with ErrorExceptionHandler {
//   static Future<PortfolioDataModel?> getPortfolio({
//     required String userid,
//   }) async {
//     try {
//       final response = await DioHelper().get(
//         '/portfolio/$userid',
//         type: ApiType.baseUrl,
//       );

//       final model = PortfolioDataModel.fromJson(response.data);
//       return model;
//     } catch (e) {
//       throw PortfolioService().handleError(e);
//     }
//   }
//   static Future<Map<String, dynamic>?> postPortfolio({
//     required String userid,
//     required Map<String, dynamic>
//     portfolioData, // Send as a Map instead of using a model
//   }) async {
//     try {
//       final response = await DioHelper().post(
//         '/portfolio/$userid',
//         type: ApiType.baseUrl,
//         data: portfolioData, // Send the map directly
//       );

//       if (response.statusCode == 404) {
//         throw Exception('Portfolio not found for user ID: $userid');
//       }

//       if (response.data != null) {
//         return response.data; // Return raw response data
//       } else {
//         throw Exception("Response data is null");
//       }
//     } catch (e) {
//       logError('Error: $e');
//       throw PortfolioService().handleError(e);
//     }
//   }

  // static Future<PortfolioDataModel?> postPortfolio({
  //   required String userid,
  //   required PortfolioDataModel portfolioData,
  // }) async {
  //   try {
  //     final response = await DioHelper().post(
  //       '/portfolio/$userid',
  //       type: ApiType.baseUrl,
  //       data: portfolioData.toJson(),
  //     );

  //     if (response.statusCode == 404) {
  //       throw Exception('Portfolio not found for user ID: $userid');
  //     }

  //     if (response.data != null) {
  //       return PortfolioDataModel.fromJson(response.data);
  //     } else {
  //       throw Exception("Response data is null");
  //     }
  //   } catch (e) {
  //     logError('Error: $e');
  //     throw PortfolioService().handleError(e);
  //   }
  // }

