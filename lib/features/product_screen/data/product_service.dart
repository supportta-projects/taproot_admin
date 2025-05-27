import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:taproot_admin/core/api/base_url_constant.dart';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/product_screen/data/product_category_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';

class ProductService with ErrorExceptionHandler {
  static Future<ProductResponse> getProduct({
    required int page,
    String? searchQuery,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        'page': page,
        if (searchQuery != null && searchQuery.isNotEmpty)
          'search': searchQuery,
      };

      final response = await DioHelper().get(
        '/product',
        type: ApiType.baseUrl,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        logSuccess("Response Data: ${response.data}");
        return ProductResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw ProductService().handleError('Failed to load products, $e');
    }
  }

  // static Future<ProductResponse> getProduct({required int page}) async {
  //   try {
  //     final response = await DioHelper().get(
  //       '/product',
  //       type: ApiType.baseUrl,
  //       queryParameters: {'page': page},
  //     );
  //     if (response.statusCode == 200) {
  //       logSuccess("Response Data: ${response.data}");
  //       return ProductResponse.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to load products');
  //     }
  //   } catch (e) {
  //     throw ProductService().handleError('Failed to load products, $e');
  //   }
  // }

  static Future<List<ProductCategory>> getProductCategory() async {
    try {
      final response = await DioHelper().get(
        '/product-category',
        type: ApiType.baseUrl,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        return data.map((item) => ProductCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load product categories');
      }
    } catch (e) {
      throw ProductService().handleError(
        'Failed to load product categories, $e',
      );
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
        '/product/upload',
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
      throw ProductService().handleError('Upload failed: $e');
    }
  }

  static Future<ProductResponse> addProduct({
    required String name,
    required String categoryId,
    required String description,
    required double actualPrice,
    required double discountPrice,
    required double discountPercentage,
    required List<ProductImage> productImages,
  }) async {
    try {
      final newProduct = Product(
        id: '',
        name: name,
        category: Category(id: categoryId),
        // coverImage: CoverImage(name: name, key: '', size: 0, mimetype: ''),
        productImages: productImages,
        actualPrice: actualPrice,
        salePrice: discountPrice,
        discountPercentage: discountPercentage,
        discountedPrice: discountPrice,
        description: description,
      );
      final response = await DioHelper().post(
        '/product',
        type: ApiType.baseUrl,
        data: newProduct.toAddJson(),
      );
      if (response.statusCode == 200) {
        logSuccess("Response Data: ${response.data}");
        return ProductResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw ProductService().handleError('Failed to load products, $e');
    }
  }
  static Future<SingleProductResponse> editProduct({
    String? name,
    String? categoryId,
    String? description,
    double? actualPrice,
    double? discountPrice,
    List<ProductImage>? productImages,
    required String productId,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        if (name != null) 'name': name,
        if (categoryId != null) 'categoryId': categoryId,
        if (description != null) 'description': description,
        if (actualPrice != null) 'actualPrice': actualPrice,
        if (discountPrice != null) 'discountPrice': discountPrice,
        if (productImages != null && productImages.isNotEmpty)
          'productImages':
              productImages
                  .map(
                    (img) => {
                      'name': img.name ?? img.key.split('-').last,
                      'key': img.key,
                      'size': img.size ?? 0,
                      'mimetype':
                          img.mimetype ??
                          'image/${img.key.split('.').last.toLowerCase()}',
                    },
                  )
                  .toList(),
      };

      logSuccess("Request Body: $requestBody");

      final response = await DioHelper().patch(
        '/product/$productId',
        type: ApiType.baseUrl,
        data: requestBody,
      );

      logSuccess("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return SingleProductResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        logError("Server Error Response: ${e.response?.data}");
        throw Exception(
          e.response?.data['message'] ?? 'Failed to update product',
        );
      }
      throw Exception('Failed to update product: $e');
    }
  }
// static Future<ProductResponse> editProduct({
//     String? name,
//     String? categoryId,
//     String? description,
//     double? actualPrice,
//     double? discountPrice,
//     List<ProductImage>? productImages,
//     required String productId,
//   }) async {
//     try {
//       final Map<String, dynamic> requestBody = {
//         if (name != null) 'name': name,
//         if (categoryId != null) 'categoryId': categoryId,
//         if (description != null) 'description': description,
//         if (actualPrice != null) 'actualPrice': actualPrice,
//         if (discountPrice != null) 'discountPrice': discountPrice,
//         if (productImages != null)
//           'productImages':
//               productImages
//                   .map(
//                     (img) => {
//                       'name':
//                           img.name ??
//                           img.key
//                               .split('-')
//                               .last, // Use filename from key if name is null
//                       'key': img.key,
//                       'size': img.size ?? 0,
//                       'mimetype':
//                           img.mimetype ??
//                           'image/${img.key.split('.').last.toLowerCase()}',
//                     },
//                   )
//                   .toList(),
//       };

//       logSuccess("Request Body: $requestBody");

//       final response = await DioHelper().patch(
//         '/product/$productId',
//         type: ApiType.baseUrl,
//         data: requestBody,
//       );

//       if (response.statusCode == 200) {
//         return ProductResponse.fromJson(response.data);
//       } else {
//         throw Exception(response.data['message'] ?? 'Failed to update product');
//       }
//     } catch (e) {
//       if (e is DioException && e.response != null) {
//         logError("Server Error Response: ${e.response?.data}");
//         throw Exception(
//           e.response?.data['message'] ?? 'Failed to update product',
//         );
//       }
//       throw ProductService().handleError('Failed to update product: $e');
//     }
//   }



  static Future<void> deleteImage(ProductImage image) async {
    try {
      final response = await DioHelper().delete(
        '/product/upload',
        type: ApiType.baseUrl,
        data: {"file": image.toJson()},
      );
      if (response.statusCode == 200) {
        logSuccess('image deleted successfully');
      } else {
        logError('image deleted failed');
      }
    } catch (e) {
      throw ProductService().handleError(e);
    }
  }
}
