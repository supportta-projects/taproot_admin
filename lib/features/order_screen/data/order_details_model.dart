// class OrderDetailsResponse {
//   final bool success;
//   final String message;
//   final OrderDetails result;

//   OrderDetailsResponse({
//     required this.success,
//     required this.message,
//     required this.result,
//   });

//   factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
//     return OrderDetailsResponse(
//       success:
//           json['success'] ?? false, // Added fallback to false for null safety
//       message: json['message'] ?? '',
//       result:
//           json['result'] != null
//               ? OrderDetails.fromJson(json['result'])
//               : OrderDetails.empty(),
//     );
//   }
// }

// class OrderDetails {
//   final Address address;
//   final NfcDetails nfcDetails;
//   final List<OrderStatusLog> orderStatusLogs;
//   final List<PaymentStatusLog> paymentStatusLogs;
//   final String createdBy;
//   final String paymentMode;
//   final String paymentServiceProvider;
//   final bool isRefunded;
//   final String id;
//   final User user;
//   final List<Product> products;
//   final num actualPrice;
//   final num discountPrice;
//   final num totalPrice;
//   final String orderStatus;
//   final String paymentStatus;
//   final bool isDeleted;
//   final String createdAt;
//   final String updatedAt;
//   final String code;
//   final int v;

//   OrderDetails({
//     required this.address,
//     required this.nfcDetails,
//     required this.orderStatusLogs,
//     required this.paymentStatusLogs,
//     required this.createdBy,
//     required this.paymentMode,
//     required this.paymentServiceProvider,
//     required this.isRefunded,
//     required this.id,
//     required this.user,
//     required this.products,
//     required this.actualPrice,
//     required this.discountPrice,
//     required this.totalPrice,
//     required this.orderStatus,
//     required this.paymentStatus,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.code,
//     required this.v,
//   });

//   // Empty constructor to handle null responses
//   factory OrderDetails.empty() {
//     return OrderDetails(
//       address: Address.empty(),
//       nfcDetails: NfcDetails.empty(),
//       orderStatusLogs: [],
//       paymentStatusLogs: [],
//       createdBy: '',
//       paymentMode: '',
//       paymentServiceProvider: '',
//       isRefunded: false,
//       id: '',
//       user: User.empty(),
//       products: [],
//       actualPrice: 0,
//       discountPrice: 0,
//       totalPrice: 0,
//       orderStatus: '',
//       paymentStatus: '',
//       isDeleted: false,
//       createdAt: '',
//       updatedAt: '',
//       code: '',
//       v: 0,
//     );
//   }

//   factory OrderDetails.fromJson(Map<String, dynamic> json) {
//     return OrderDetails(
//       address: Address.fromJson(json['address']),
//       nfcDetails: NfcDetails.fromJson(json['nfcDetails']),
//       orderStatusLogs:
//           (json['orderStatusLogs'] as List)
//               .map((e) => OrderStatusLog.fromJson(e))
//               .toList(),
//       paymentStatusLogs:
//           (json['paymentStatusLogs'] as List)
//               .map((e) => PaymentStatusLog.fromJson(e))
//               .toList(),
//       createdBy: json['createdBy'] ?? '',
//       paymentMode: json['paymentMode'] ?? '',
//       paymentServiceProvider: json['paymentServiceProvider'] ?? '',
//       isRefunded: json['isRefunded'] ?? false,
//       id: json['_id'] ?? '',
//       user: User.fromJson(json['user']),
//       products:
//           (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
//       actualPrice: json['actualPrice'] ?? 0,
//       discountPrice: json['discountPrice'] ?? 0,
//       totalPrice: json['totalPrice'] ?? 0,
//       orderStatus: json['orderStatus'] ?? '',
//       paymentStatus: json['paymentStatus'] ?? '',
//       isDeleted: json['isDeleted'] ?? false,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       code: json['code'] ?? '',
//       v: json['__v'] ?? 0,
//     );
//   }
// }

// class Address {
//   final String name;
//   final String mobile;
//   final String address1;
//   final String address2;
//   final String landmark;
//   final String pincode;
//   final String district;
//   final String state;
//   final String country;

//   Address({
//     required this.name,
//     required this.mobile,
//     required this.address1,
//     required this.address2,
//     required this.landmark,
//     required this.pincode,
//     required this.district,
//     required this.state,
//     required this.country,
//   });

//   factory Address.empty() {
//     return Address(
//       name: '',
//       mobile: '',
//       address1: '',
//       address2: '',
//       landmark: '',
//       pincode: '',
//       district: '',
//       state: '',
//       country: '',
//     );
//   }

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       name: json['name'] ?? '',
//       mobile: json['mobile'] ?? '',
//       address1: json['address1'] ?? '',
//       address2: json['address2'] ?? '',
//       landmark: json['landmark'] ?? '',
//       pincode: json['pincode'] ?? '',
//       district: json['district'] ?? '',
//       state: json['state'] ?? '',
//       country: json['country'] ?? '',
//     );
//   }
// }

// class NfcDetails {
//   final CustomerFile customerLogo;
//   final CustomerFile customerPhoto;
//   final String customerName;
//   final String designation;

//   NfcDetails({
//     required this.customerLogo,
//     required this.customerPhoto,
//     required this.customerName,
//     required this.designation,
//   });

//   factory NfcDetails.empty() {
//     return NfcDetails(
//       customerLogo: CustomerFile.empty(),
//       customerPhoto: CustomerFile.empty(),
//       customerName: '',
//       designation: '',
//     );
//   }

//   factory NfcDetails.fromJson(Map<String, dynamic> json) {
//     return NfcDetails(
//       customerLogo: CustomerFile.fromJson(json['customerLogo']),
//       customerPhoto: CustomerFile.fromJson(json['customerPhoto']),
//       customerName: json['customerName'] ?? '',
//       designation: json['designation'] ?? '',
//     );
//   }
// }

// class CustomerFile {
//   final String mimetype;
//   final String size;

//   CustomerFile({required this.mimetype, required this.size});

//   factory CustomerFile.empty() {
//     return CustomerFile(mimetype: '', size: '');
//   }

//   factory CustomerFile.fromJson(Map<String, dynamic> json) {
//     return CustomerFile(
//       mimetype: json['mimetype'] ?? '',
//       size: json['size'] ?? '',
//     );
//   }
// }

// class OrderStatusLog {
//   final String status;
//   final DateTime changedAt;
//   final String id;

//   OrderStatusLog({
//     required this.status,
//     required this.changedAt,
//     required this.id,
//   });

//   factory OrderStatusLog.fromJson(Map<String, dynamic> json) {
//     return OrderStatusLog(
//       status: json['status'] ?? '',
//       changedAt: DateTime.parse(
//         json['orderDate'] ?? DateTime.now().toIso8601String(),
//       ),
//       id: json['_id'] ?? '',
//     );
//   }
// }

// class PaymentStatusLog {
//   final String status;
//   final String changedAt;
//   final String id;

//   PaymentStatusLog({
//     required this.status,
//     required this.changedAt,
//     required this.id,
//   });

//   factory PaymentStatusLog.fromJson(Map<String, dynamic> json) {
//     return PaymentStatusLog(
//       status: json['status'] ?? '',
//       changedAt: json['changedAt'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }
// }

// class User {
//   final String id;
//   final String name;
//   final String email;

//   User({required this.id, required this.name, required this.email});

//   factory User.empty() {
//     return User(id: '', name: '', email: '');
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//     );
//   }
// }

// class Product {
//   final String product;
//   final int quantity;
//   final num actualPrice;
//   final num discountedPrice;
//   final num totalPrice;
//   final String id;

//   Product({
//     required this.product,
//     required this.quantity,
//     required this.actualPrice,
//     required this.discountedPrice,
//     required this.totalPrice,
//     required this.id,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       product: json['product'] ?? '',
//       quantity: json['quantity'] ?? 0,
//       actualPrice: json['actualPrice'] ?? 0,
//       discountedPrice: json['discountedPrice'] ?? 0,
//       totalPrice: json['totalPrice'] ?? 0,
//       id: json['_id'] ?? '',
//     );
//   }
// }
// ------------------------------

class OrderDetailsResponse {
  final bool success;
  final String message;
  final OrderDetails result;

  OrderDetailsResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result:
          json['result'] != null
              ? OrderDetails.fromJson(json['result'] as Map<String, dynamic>)
              : OrderDetails.empty(),
    );
  }
}

class OrderDetails {
  final String id;
  final String code;
  final User user;
  final List<OrderProduct> products;
  final Address address;
  final NfcDetails nfcDetails;
  final double totalPrice;
  final String orderStatus;
  final String createdBy;
  final String paymentMode;
  final String paymentServiceProvider;
  final String paymentStatus;
  final bool isRefunded;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String razorpayPaymentLink;
  final String razorpayPaymentLinkId;
  final String paymentMethod;
  final PaymentStatusLogs paymentStatusLogs;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final PersonalInfo personalInfo;

  OrderDetails({
    required this.id,
    required this.code,
    required this.user,
    required this.products,
    required this.address,
    required this.nfcDetails,
    required this.totalPrice,
    required this.orderStatus,
    required this.createdBy,
    required this.paymentMode,
    required this.paymentServiceProvider,
    required this.paymentStatus,
    required this.isRefunded,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.razorpayPaymentLink,
    required this.razorpayPaymentLinkId,
    required this.paymentMethod,
    required this.paymentStatusLogs,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.personalInfo,
  });

  factory OrderDetails.empty() {
    return OrderDetails(
      id: '',
      code: '',
      user: User.empty(),
      products: [],
      address: Address.empty(),
      nfcDetails: NfcDetails.empty(),
      totalPrice: 0,
      orderStatus: '',
      createdBy: '',
      paymentMode: '',
      paymentServiceProvider: '',
      paymentStatus: '',
      isRefunded: false,
      isDeleted: false,
      createdAt: '',
      updatedAt: '',
      v: 0,
      razorpayPaymentLink: '',
      razorpayPaymentLinkId: '',
      paymentMethod: '',
      paymentStatusLogs: PaymentStatusLogs.empty(),
      razorpayOrderId: '',
      razorpayPaymentId: '',
      personalInfo: PersonalInfo.empty(),
    );
  }

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['_id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      address: Address.fromJson(json['address'] as Map<String, dynamic>? ?? {}),
      nfcDetails: NfcDetails.fromJson(
        json['nfcDetails'] as Map<String, dynamic>? ?? {},
      ),
      totalPrice: double.tryParse(json['totalPrice']?.toString() ?? '0') ?? 0.0,
      orderStatus: json['orderStatus']?.toString() ?? '',
      createdBy: json['createdBy']?.toString() ?? '',
      paymentMode: json['paymentMode']?.toString() ?? '',
      paymentServiceProvider: json['paymentServiceProvider']?.toString() ?? '',
      paymentStatus: json['paymentStatus']?.toString() ?? '',
      isRefunded: json['isRefunded'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: int.tryParse(json['__v']?.toString() ?? '0') ?? 0,
      razorpayPaymentLink: json['razorpayPaymentLink']?.toString() ?? '',
      razorpayPaymentLinkId: json['razorpayPaymentLinkId']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      paymentStatusLogs: PaymentStatusLogs.fromJson(
        json['paymentStatusLogs'] as Map<String, dynamic>? ?? {},
      ),
      razorpayOrderId: json['razorpayOrderId']?.toString() ?? '',
      razorpayPaymentId: json['razorpayPaymentId']?.toString() ?? '',
      personalInfo: PersonalInfo.fromJson(
        json['personalInfo'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.empty() {
    return User(id: '', name: '', email: '');
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }
}

class OrderProduct {
  final ProductDetails product;
  final int quantity; // Keep as int since it's a count
  final double salePrice; // Already double
  final double discountPercentage; // Changed from num to double
  final double totalPrice; // Changed from num to double
  final String id;

  OrderProduct({
    required this.product,
    required this.quantity,
    required this.salePrice,
    required this.discountPercentage,
    required this.totalPrice,
    required this.id,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      product: ProductDetails.fromJson(
        json['product'] as Map<String, dynamic>? ?? {},
      ),
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      salePrice: double.tryParse(json['salePrice']?.toString() ?? '0') ?? 0.0,
      discountPercentage:
          double.tryParse(json['discountPercentage']?.toString() ?? '0') ?? 0.0,
      totalPrice: double.tryParse(json['totalPrice']?.toString() ?? '0') ?? 0.0,
      id: json['_id']?.toString() ?? '',
    );
  }
}

class ProductDetails {
  final String id;
  final String name;
  final Category category;
  final ProductImages productImages;
  final double actualPrice;
  final double salePrice;
  final double discountPercentage;
  final double discountedPrice;
  final String code;

  ProductDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.productImages,
    required this.actualPrice,
    required this.salePrice,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.code,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: Category.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ),
      productImages: ProductImages.fromJson(
        json['productImages'] as Map<String, dynamic>? ?? {},
      ),
      actualPrice:
          double.tryParse(json['actualPrice']?.toString() ?? '0') ?? 0.0,
      salePrice: double.tryParse(json['salePrice']?.toString() ?? '0') ?? 0.0,
      discountPercentage:
          double.tryParse(json['discountPercentage']?.toString() ?? '0') ?? 0.0,
      discountedPrice:
          double.tryParse(json['discountedPrice']?.toString() ?? '0') ?? 0.0,
      code: json['code']?.toString() ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class ProductImages {
  final String name;
  final String key;
  final int size;
  final String mimetype;
  final String id;

  ProductImages({
    required this.name,
    required this.key,
    required this.size,
    required this.mimetype,
    required this.id,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
      name: json['name']?.toString() ?? '',
      key: json['key']?.toString() ?? '',
      size: int.tryParse(json['size']?.toString() ?? '0') ?? 0,
      mimetype: json['mimetype']?.toString() ?? '',
      id: json['_id']?.toString() ?? '',
    );
  }
}

class Address {
  final String name;
  final String mobile;
  final String address1;
  final String address2;
  final String landmark;
  final String pincode;
  final String district;
  final String state;
  final String country;

  Address({
    required this.name,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.landmark,
    required this.pincode,
    required this.district,
    required this.state,
    required this.country,
  });

  factory Address.empty() {
    return Address(
      name: '',
      mobile: '',
      address1: '',
      address2: '',
      landmark: '',
      pincode: '',
      district: '',
      state: '',
      country: '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'address1': address1,
      'address2': address2,
      'landmark': landmark,
      'pincode': pincode,
      'district': district,
      'state': state,
      'country': country,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      address1: json['address1']?.toString() ?? '',
      address2: json['address2']?.toString() ?? '',
      landmark: json['landmark']?.toString() ?? '',
      pincode: json['pincode']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
    );
  }
}

class NfcDetails {
  final String customerName;
  final String designation;
  final CustomerFile customerLogo;
  final CustomerFile customerPhoto;

  NfcDetails({
    required this.customerName,
    required this.designation,
    required this.customerLogo,
    required this.customerPhoto,
  });

  factory NfcDetails.empty() {
    return NfcDetails(
      customerName: '',
      designation: '',
      customerLogo: CustomerFile.empty(),
      customerPhoto: CustomerFile.empty(),
    );
  }

  factory NfcDetails.fromJson(Map<String, dynamic> json) {
    return NfcDetails(
      customerName: json['customerName']?.toString() ?? '',
      designation: json['designation']?.toString() ?? '',
      customerLogo: CustomerFile.fromJson(
        json['customerLogo'] as Map<String, dynamic>? ?? {},
      ),
      customerPhoto: CustomerFile.fromJson(
        json['customerPhoto'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class CustomerFile {
  final ImageDetails image;
  final String source;

  CustomerFile({required this.image, required this.source});

  factory CustomerFile.empty() {
    return CustomerFile(image: ImageDetails.empty(), source: '');
  }

  factory CustomerFile.fromJson(Map<String, dynamic> json) {
    return CustomerFile(
      image: ImageDetails.fromJson(
        json['image'] as Map<String, dynamic>? ?? {},
      ),
      source: json['source']?.toString() ?? '',
    );
  }
}

class ImageDetails {
  final String name;
  final String key;
  final int size;
  final String mimetype;

  ImageDetails({
    required this.name,
    required this.key,
    required this.size,
    required this.mimetype,
  });

  factory ImageDetails.empty() {
    return ImageDetails(name: '', key: '', size: 0, mimetype: '');
  }

  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(
      name: json['name']?.toString() ?? '',
      key: json['key']?.toString() ?? '',
      size: int.tryParse(json['size']?.toString() ?? '0') ?? 0,
      mimetype: json['mimetype']?.toString() ?? '',
    );
  }
}

class PaymentStatusLogs {
  final String paymentSuccessAt;

  PaymentStatusLogs({required this.paymentSuccessAt});

  factory PaymentStatusLogs.empty() {
    return PaymentStatusLogs(paymentSuccessAt: '');
  }

  factory PaymentStatusLogs.fromJson(Map<String, dynamic> json) {
    return PaymentStatusLogs(
      paymentSuccessAt: json['paymentSuccessAt']?.toString() ?? '',
    );
  }
}

class PersonalInfo {
  final String whatsappNumber;
  final String phoneNumber;
  final String name;
  final String email;

  PersonalInfo({
    required this.whatsappNumber,
    required this.phoneNumber,
    required this.name,
    required this.email,
  });

  factory PersonalInfo.empty() {
    return PersonalInfo(
      whatsappNumber: '',
      phoneNumber: '',
      name: '',
      email: '',
    );
  }

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      whatsappNumber: json['whatsappNumber']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }
}
