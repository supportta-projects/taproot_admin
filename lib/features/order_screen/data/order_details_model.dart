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
      success:
          json['success'] ?? false, // Added fallback to false for null safety
      message: json['message'] ?? '',
      result:
          json['result'] != null
              ? OrderDetails.fromJson(json['result'])
              : OrderDetails.empty(),
    );
  }
}

class OrderDetails {
  final Address address;
  final NfcDetails nfcDetails;
  final List<OrderStatusLog> orderStatusLogs;
  final List<PaymentStatusLog> paymentStatusLogs;
  final String createdBy;
  final String paymentMode;
  final String paymentServiceProvider;
  final bool isRefunded;
  final String id;
  final User user;
  final List<Product> products;
  final num actualPrice;
  final num discountPrice;
  final num totalPrice;
  final String orderStatus;
  final String paymentStatus;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String code;
  final int v;

  OrderDetails({
    required this.address,
    required this.nfcDetails,
    required this.orderStatusLogs,
    required this.paymentStatusLogs,
    required this.createdBy,
    required this.paymentMode,
    required this.paymentServiceProvider,
    required this.isRefunded,
    required this.id,
    required this.user,
    required this.products,
    required this.actualPrice,
    required this.discountPrice,
    required this.totalPrice,
    required this.orderStatus,
    required this.paymentStatus,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.v,
  });

  // Empty constructor to handle null responses
  factory OrderDetails.empty() {
    return OrderDetails(
      address: Address.empty(),
      nfcDetails: NfcDetails.empty(),
      orderStatusLogs: [],
      paymentStatusLogs: [],
      createdBy: '',
      paymentMode: '',
      paymentServiceProvider: '',
      isRefunded: false,
      id: '',
      user: User.empty(),
      products: [],
      actualPrice: 0,
      discountPrice: 0,
      totalPrice: 0,
      orderStatus: '',
      paymentStatus: '',
      isDeleted: false,
      createdAt: '',
      updatedAt: '',
      code: '',
      v: 0,
    );
  }

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      address: Address.fromJson(json['address']),
      nfcDetails: NfcDetails.fromJson(json['nfcDetails']),
      orderStatusLogs:
          (json['orderStatusLogs'] as List)
              .map((e) => OrderStatusLog.fromJson(e))
              .toList(),
      paymentStatusLogs:
          (json['paymentStatusLogs'] as List)
              .map((e) => PaymentStatusLog.fromJson(e))
              .toList(),
      createdBy: json['createdBy'] ?? '',
      paymentMode: json['paymentMode'] ?? '',
      paymentServiceProvider: json['paymentServiceProvider'] ?? '',
      isRefunded: json['isRefunded'] ?? false,
      id: json['_id'] ?? '',
      user: User.fromJson(json['user']),
      products:
          (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      actualPrice: json['actualPrice'] ?? 0,
      discountPrice: json['discountPrice'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      orderStatus: json['orderStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      code: json['code'] ?? '',
      v: json['__v'] ?? 0,
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      landmark: json['landmark'] ?? '',
      pincode: json['pincode'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

class NfcDetails {
  final CustomerFile customerLogo;
  final CustomerFile customerPhoto;
  final String customerName;
  final String designation;

  NfcDetails({
    required this.customerLogo,
    required this.customerPhoto,
    required this.customerName,
    required this.designation,
  });

  factory NfcDetails.empty() {
    return NfcDetails(
      customerLogo: CustomerFile.empty(),
      customerPhoto: CustomerFile.empty(),
      customerName: '',
      designation: '',
    );
  }

  factory NfcDetails.fromJson(Map<String, dynamic> json) {
    return NfcDetails(
      customerLogo: CustomerFile.fromJson(json['customerLogo']),
      customerPhoto: CustomerFile.fromJson(json['customerPhoto']),
      customerName: json['customerName'] ?? '',
      designation: json['designation'] ?? '',
    );
  }
}

class CustomerFile {
  final String mimetype;
  final String size;

  CustomerFile({required this.mimetype, required this.size});

  factory CustomerFile.empty() {
    return CustomerFile(mimetype: '', size: '');
  }

  factory CustomerFile.fromJson(Map<String, dynamic> json) {
    return CustomerFile(
      mimetype: json['mimetype'] ?? '',
      size: json['size'] ?? '',
    );
  }
}

class OrderStatusLog {
  final String status;
  final DateTime changedAt;
  final String id;

  OrderStatusLog({
    required this.status,
    required this.changedAt,
    required this.id,
  });

  factory OrderStatusLog.fromJson(Map<String, dynamic> json) {
    return OrderStatusLog(
      status: json['status'] ?? '',
      changedAt: DateTime.parse(
        json['orderDate'] ?? DateTime.now().toIso8601String(),
      ),
      id: json['_id'] ?? '',
    );
  }
}

class PaymentStatusLog {
  final String status;
  final String changedAt;
  final String id;

  PaymentStatusLog({
    required this.status,
    required this.changedAt,
    required this.id,
  });

  factory PaymentStatusLog.fromJson(Map<String, dynamic> json) {
    return PaymentStatusLog(
      status: json['status'] ?? '',
      changedAt: json['changedAt'] ?? '',
      id: json['_id'] ?? '',
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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}



class Product {
  final String product;
  final int quantity;
  final num actualPrice;
  final num discountedPrice;
  final num totalPrice;
  final String id;

  Product({
    required this.product,
    required this.quantity,
    required this.actualPrice,
    required this.discountedPrice,
    required this.totalPrice,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product: json['product'] ?? '',
      quantity: json['quantity'] ?? 0,
      actualPrice: json['actualPrice'] ?? 0,
      discountedPrice: json['discountedPrice'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}
