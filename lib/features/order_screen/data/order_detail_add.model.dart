class OrderPostModel {
  final NfcDetails nfcDetails;
  final double totalPrice;
  final List<ProductQuantity> products;
  final Address address;

  OrderPostModel({
    required this.nfcDetails,
    required this.totalPrice,
    required this.products,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'nfcDetails': nfcDetails.toJson(),
    'totalPrice': totalPrice,
    'products': products.map((e) => e.toJson()).toList(),
    'address': address.toJson(),
  };
}

class NfcDetails {
  final String customerName;
  final String? designation;
  final ImageSource customerLogo;
  final ImageSource customerPhoto;

  NfcDetails({
    required this.customerName,
     this.designation,
    required this.customerLogo,
    required this.customerPhoto,
  });

  Map<String, dynamic> toJson() => {
    'customerName': customerName,
    'designation': designation,
    'customerLogo': customerLogo.toJson(),
    'customerPhoto': customerPhoto.toJson(),
  };
}

class ImageSource {
  final ImageDetails? image;
  final String source;

  ImageSource({ this.image, required this.source});

  Map<String, dynamic> toJson() => {'image': image?.toJson(), 'source': source};
}

class ImageDetails {
  final String key;
  final String name;
  final String mimetype;
  final int size;

  ImageDetails({
    required this.key,
    required this.name,
    required this.mimetype,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'name': name,
    'mimetype': mimetype,
    'size': size,
  };
}

class ProductQuantity {
  final String product;
  final int quantity;

  ProductQuantity({required this.product, required this.quantity});

  Map<String, dynamic> toJson() => {'product': product, 'quantity': quantity};
}

class Address {
  final String name;
  final String mobile;
  final String address1;
  final String address2;
  final String pincode;
  final String district;
  final String state;
  final String country;

  Address({
    required this.name,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.pincode,
    required this.district,
    required this.state,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'mobile': mobile,
    'address1': address1,
    'address2': address2,
    'pincode': pincode,
    'district': district,
    'state': state,
    'country': country,
  };
}
