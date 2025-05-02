class PortfolioDataModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String whatsappNumber;

  final String companyName;
  final String designation;
  final String workEmail;
  final String primaryWebsite;
  final String secondaryWebsite;

  final String buildingName;
  final String area;
  final String pincode;
  final String district;
  final String state;

  final String aboutHeading;
  final String aboutDescription;

  final String userId;
  final String userCode;
  final bool isPremium;

  final List<Service> services;

  PortfolioDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.companyName,
    required this.designation,
    required this.workEmail,
    required this.primaryWebsite,
    required this.secondaryWebsite,
    required this.buildingName,
    required this.area,
    required this.pincode,
    required this.district,
    required this.state,
    required this.aboutHeading,
    required this.aboutDescription,
    required this.userId,
    required this.userCode,
    required this.isPremium,
    required this.services,
  });

  factory PortfolioDataModel.fromJson(Map<String, dynamic> json) {
    final portfolio = json['portfolio'];
    final personalInfo = portfolio['personalInfo'];
    final workInfo = portfolio['workInfo'];
    final addressInfo = portfolio['addressInfo'];
    final about = portfolio['about'];
    final user = portfolio['user'];

    return PortfolioDataModel(
      id: portfolio['_id'],
      name: personalInfo['name'],
      email: personalInfo['email'],
      phoneNumber: personalInfo['phoneNumber'],
      whatsappNumber: personalInfo['whatsappNumber'],
      companyName: workInfo['companyName'],
      designation: workInfo['designation'],
      workEmail: workInfo['workEmail'],
      primaryWebsite: workInfo['primaryWebsite'],
      secondaryWebsite: workInfo['secondaryWebsite'],
      buildingName: addressInfo['buildingName'],
      area: addressInfo['area'],
      pincode: addressInfo['pincode'],
      district: addressInfo['district'],
      state: addressInfo['state'],
      aboutHeading: about['heading'],
      aboutDescription: about['description'],
      userId: user['_id'],
      userCode: user['code'],
      isPremium: user['isPremium'],
      services: List<Service>.from(
        json['services'].map((x) => Service.fromJson(x)),
      ),
    );
  }
}

class Service {
  final String id;
  final String user;
  final String portfolio;
  final String heading;
  final String description;
  final DateTime createdAt;

  Service({
    required this.id,
    required this.user,
    required this.portfolio,
    required this.heading,
    required this.description,
    required this.createdAt,
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
}
