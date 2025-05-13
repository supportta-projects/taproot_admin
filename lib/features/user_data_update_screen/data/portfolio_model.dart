class PortfolioDataModel {
  final String id;
  final PersonalInfo personalInfo;
  final WorkInfo workInfo;
  final AddressInfo addressInfo;
  final About about;
  final UserInfo user;
  final List<SocialMedia> socialMedia;
  final List<Service> services;

  PortfolioDataModel({
    required this.id,
    required this.personalInfo,
    required this.workInfo,
    required this.addressInfo,
    required this.about,
    required this.user,
    required this.socialMedia,
    required this.services,
  });

  factory PortfolioDataModel.fromJson(Map<String, dynamic> json) {
    final portfolio = json['result']['portfolio'];

    return PortfolioDataModel(
      id: portfolio['_id'],
      personalInfo: PersonalInfo.fromJson(portfolio['personalInfo']),
      workInfo: WorkInfo.fromJson(portfolio['workInfo']),
      addressInfo: AddressInfo.fromJson(portfolio['addressInfo']),
      about: About.fromJson(portfolio['about']),
      user: UserInfo.fromJson(portfolio['user']),
      socialMedia:
          (portfolio['socialMedia'] as List<dynamic>)
              .map((e) => SocialMedia.fromJson(e))
              .toList(),
      services:
          (json['result']['services'] as List<dynamic>)
              .map((e) => Service.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personalInfo': personalInfo.toJson(),
      'workInfo': workInfo.toJson(),
      'addressInfo': addressInfo.toJson(),
      'about': about.toJson(),
      'user': user.toJson(),
      'socialMedia': socialMedia.map((e) => e.toJson()).toList(),
      'services': services.map((e) => e.toJson()).toList(),
    };
  }
}

class PersonalInfo {
  final String name;
  final String email;
  final String phoneNumber;
  final String whatsappNumber;
  final String? bannerImage;
  final String? profileImage;

  PersonalInfo({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.whatsappNumber,
    this.bannerImage,
    this.profileImage,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      whatsappNumber: json['whatsappNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'whatsappNumber': whatsappNumber,
  };
}

class WorkInfo {
  final String companyName;
  final String designation;
  final String workEmail;
  final String primaryWebsite;
  final String secondaryWebsite;

  WorkInfo({
    required this.companyName,
    required this.designation,
    required this.workEmail,
    required this.primaryWebsite,
    required this.secondaryWebsite,
  });

  factory WorkInfo.fromJson(Map<String, dynamic> json) {
    return WorkInfo(
      companyName: json['companyName'],
      designation: json['designation'],
      workEmail: json['workEmail'],
      primaryWebsite: json['primaryWebsite'],
      secondaryWebsite: json['secondaryWebsite'],
    );
  }

  Map<String, dynamic> toJson() => {
    'companyName': companyName,
    'designation': designation,
    'workEmail': workEmail,
    'primaryWebsite': primaryWebsite,
    'secondaryWebsite': secondaryWebsite,
  };
}

class AddressInfo {
  final String buildingName;
  final String area;
  final String pincode;
  final String district;
  final String state;

  AddressInfo({
    required this.buildingName,
    required this.area,
    required this.pincode,
    required this.district,
    required this.state,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      buildingName: json['buildingName'],
      area: json['area'],
      pincode: json['pincode'],
      district: json['district'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
    'buildingName': buildingName,
    'area': area,
    'pincode': pincode,
    'district': district,
    'state': state,
  };
}

class About {
  final String heading;
  final String description;

  About({required this.heading, required this.description});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(heading: json['heading'], description: json['description']);
  }

  Map<String, dynamic> toJson() => {
    'heading': heading,
    'description': description,
  };
}

class UserInfo {
  final String id;
  final String code;
  final bool isPremium;

  UserInfo({required this.id, required this.code, required this.isPremium});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      code: json['code'],
      isPremium: json['isPremium'] == true || json['isPremium'] == 'true',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'code': code,
    'isPremium': isPremium,
  };
}

class SocialMedia {
  final String? id;
  final String source;
  final String link;

  SocialMedia({required this.id, required this.source, required this.link});

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      id: json['_id'],
      source: json['source'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'source': source, 'link': link};
    if (id != null && id!.isNotEmpty) {
      data['_id'] = id;
    }
    return data;
  }
}

class Service {
  final String ?id;
  final String? user;
  final String? portfolio;
  final String heading;
  final String description;
  final DateTime? createdAt;

  Service({
     this.id,
     this.user,
     this.portfolio,
    required this.heading,
    required this.description,
   this.createdAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      user: json['user'],
      portfolio: json['portfolio'],
      heading: json['heading'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'user': user,
    'portfolio': portfolio,
    'heading': heading,
    'description': description,
    'createdAt': createdAt?.toIso8601String(),
  };
}
