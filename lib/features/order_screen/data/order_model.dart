class OrderResponse {
  final int currentPage;
  final List<Order> results;
  final int totalCount;
  final int totalPages;

  OrderResponse({
    required this.currentPage,
    required this.results,
    required this.totalCount,
    required this.totalPages,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      currentPage: json['currentPage'],
      results: List<Order>.from(json['results'].map((x) => Order.fromJson(x))),
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() => {
    'currentPage': currentPage,
    'results': results.map((x) => x.toJson()).toList(),
    'totalCount': totalCount,
    'totalPages': totalPages,
  };
}

class Order {
  final String id;
  final String code;
  final String paymentStatus;
  final bool isDeleted;
  final User user;
  final Address address;
  final NfcDetails nfcDetails;
  final List<ProductItem> products;

  Order({
    required this.id,
    required this.code,
    required this.paymentStatus,
    required this.isDeleted,
    required this.user,
    required this.address,
    required this.nfcDetails,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      code: json['code'],
      paymentStatus: json['paymentStatus'],
      isDeleted: json['isDeleted'],
      user: User.fromJson(json['user']),
      address: Address.fromJson(json['address']),
      nfcDetails: NfcDetails.fromJson(json['nfcDetails']),
      products: List<ProductItem>.from(
        json['products'].map((x) => ProductItem.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'code': code,
    'paymentStatus': paymentStatus,
    'isDeleted': isDeleted,
    'user': user.toJson(),
    'address': address.toJson(),
    'nfcDetails': nfcDetails.toJson(),
    'products': products.map((x) => x.toJson()).toList(),
  };
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'email': email};
}

class Address {
  final String mobile;

  Address({required this.mobile});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(mobile: json['mobile']);
  }

  Map<String, dynamic> toJson() => {'mobile': mobile};
}

class NfcDetails {
  final String customerName;

  NfcDetails({required this.customerName});

  factory NfcDetails.fromJson(Map<String, dynamic> json) {
    return NfcDetails(customerName: json['customerName']);
  }

  Map<String, dynamic> toJson() => {'customerName': customerName};
}

class ProductItem {
  final String id;
  final String product;
  final String quantity;
  final double totalPrice;
  final double? salePrice;
  final double? discountPercentage;
  final double? actualPrice;
  final double? discountedPrice;

  ProductItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    this.salePrice,
    this.discountPercentage,
    this.actualPrice,
    this.discountedPrice,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['_id'],
      product: json['product'],
      quantity: json['quantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      salePrice:
          json['salePrice'] != null
              ? (json['salePrice'] as num).toDouble()
              : null,
      discountPercentage:
          json['discountPercentage'] != null
              ? (json['discountPercentage'] as num).toDouble()
              : null,
      actualPrice:
          json['actualPrice'] != null
              ? (json['actualPrice'] as num).toDouble()
              : null,
      discountedPrice:
          json['discountedPrice'] != null
              ? (json['discountedPrice'] as num).toDouble()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'product': product,
    'quantity': quantity,
    'totalPrice': totalPrice,
    if (salePrice != null) 'salePrice': salePrice,
    if (discountPercentage != null) 'discountPercentage': discountPercentage,
    if (actualPrice != null) 'actualPrice': actualPrice,
    if (discountedPrice != null) 'discountedPrice': discountedPrice,
  };
}
