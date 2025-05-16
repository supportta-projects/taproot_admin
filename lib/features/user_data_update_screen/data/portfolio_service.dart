import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http_parser/http_parser.dart';
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

  static Future<PortfolioDataModel?> editPortfolio({
    required String userid,
    required Map<String, dynamic> portfolioEditedData,
  }) async {
    try {
      final response = await DioHelper().patch(
        '/portfolio/$userid',
        type: ApiType.baseUrl,
        data: portfolioEditedData,
      );

      if (response.statusCode == 200) {
        return PortfolioDataModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        final msg = response.data['message'] as String?;
        throw Exception(msg ?? 'Invalid portfolio data');
      } else if (response.statusCode == 404) {
        throw Exception('Portfolio not found for user ID: $userid');
      } else {
        throw Exception('Failed to edit portfolio');
      }
    } catch (e) {
      logError('EditPortfolio Error: $e');
      throw PortfolioService().handleError(e);
    }
  }

  static Future<PortfolioDataModel> addService({
    required String userId,
    required String portfolioId,
    required Map<String, dynamic> serviceData,
  }) async {
    try {
      // final formData = FormData.fromMap(serviceData);
      final response = await DioHelper().post(
        '/portfolio-service/$userId/service/$portfolioId',
        type: ApiType.baseUrl,
        data: serviceData,
      );
      if (response.statusCode == 200) {
        return PortfolioDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to add service');
      }
    } catch (e) {
      logError('AddService Error: $e');
      throw PortfolioService().handleError(e);
    }
  }

  static Future<PortfolioDataModel> editService({
    required String serviceId,
    required Map<String, dynamic> editServiceData,
  }) async {
    try {
      final response = await DioHelper().patch(
        '/portfolio-service/service/$serviceId',
        type: ApiType.baseUrl,
        data: editServiceData,
      );
      if (response.statusCode == 200) {
        return PortfolioDataModel.fromJson(response.data);
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      logError('Edit service Error:$e');
      throw Exception('Edit service failed: $e');
    }
  }

  static Future<Map<String, dynamic>> uploadImageFile(
    Uint8List imageBytes,
    String filename,
  ) async {
    try {
      final formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: filename,
          contentType: MediaType('image', 'jpeg'), // adjust if PNG
        ),
      });

      final response = await DioHelper().post(
        '/portfolio/upload',
        type: ApiType.baseUrl,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.data != null && response.data['result'] != null) {
        final result = response.data['result'] as Map<String, dynamic>;
        logSuccess('Upload success: $result');
        return result;
      } else {
        throw Exception('Invalid upload response');
      }
    } catch (e) {
      logError('Upload failed: $e');
      throw PortfolioService().handleError('Upload failed: $e');
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

