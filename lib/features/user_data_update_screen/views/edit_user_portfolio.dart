import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/views/add_user_portfolio.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/about_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/additional_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/padding_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/profile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class EditUserPortfolio extends StatefulWidget {
  final PortfolioDataModel? portfolio;
  final VoidCallback onCallFunction;

  final User user;
  const EditUserPortfolio({
    super.key,
    required this.user,
    required this.portfolio,
    required this.onCallFunction,
  });

  @override
  State<EditUserPortfolio> createState() => _EditUserPortfolioState();
}

class _EditUserPortfolioState extends State<EditUserPortfolio> {
  PortfolioDataModel? theFetchedPortfolio;
  // PlatformFile? pickedImage;
  // String? previewImageUrl;
  // Uint8List? previewImageBytes;
  PlatformFile? pickedProfileImage; // For profile image
  PlatformFile? pickedLogoImage; // For logo image
  PlatformFile? pickedBannerImage; // For banner image
  Uint8List? previewProfileBytes;
  Uint8List? previewLogoBytes;
  Uint8List? previewBannerBytes;
  ProductImage? pickedServiceImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController whatsappNumberController =
      TextEditingController();
  final TextEditingController designationcontroller = TextEditingController();

  final TextEditingController companyNameController = TextEditingController();

  final TextEditingController workemailController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController buildingNamecontroller = TextEditingController();
  final TextEditingController primaryWebsiteController =
      TextEditingController();
  final TextEditingController secondaryWebsiteController =
      TextEditingController();
  final TextEditingController headingcontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController serviceHeadController = TextEditingController();

  final TextEditingController serviceHeadingController =
      TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();

  List<SocialMedia> socialLinks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedTexfieldValue();
  }

  void fetchedTexfieldValue() {
    theFetchedPortfolio = widget.portfolio;

    nameController.text = theFetchedPortfolio?.personalInfo.name ?? '';
    emailController.text = theFetchedPortfolio!.personalInfo.email;
    phoneNumberController.text = theFetchedPortfolio!.personalInfo.phoneNumber;
    whatsappNumberController.text =
        theFetchedPortfolio!.personalInfo.whatsappNumber;
    companyNameController.text = theFetchedPortfolio!.workInfo.companyName;
    designationcontroller.text = theFetchedPortfolio!.workInfo.designation;
    workemailController.text = theFetchedPortfolio!.workInfo.workEmail;
    areaController.text = theFetchedPortfolio!.addressInfo.area;
    pincodeController.text = theFetchedPortfolio!.addressInfo.pincode;
    districtController.text = theFetchedPortfolio!.addressInfo.district;
    stateController.text = theFetchedPortfolio!.addressInfo.state;
    buildingNamecontroller.text = theFetchedPortfolio!.addressInfo.buildingName;
    primaryWebsiteController.text =
        theFetchedPortfolio!.workInfo.primaryWebsite;
    secondaryWebsiteController.text =
        theFetchedPortfolio!.workInfo.secondaryWebsite;
    headingcontroller.text = theFetchedPortfolio!.about.heading;
    descriptioncontroller.text = theFetchedPortfolio!.about.description;
    if (theFetchedPortfolio!.services.isNotEmpty) {
      serviceHeadController.text = theFetchedPortfolio!.serviceHeading;
      serviceHeadingController.text = theFetchedPortfolio!.services[0].heading;
      serviceDescriptionController.text =
          theFetchedPortfolio!.services[0].description;
    } else {
      // Initialize with empty strings if no services exist
      serviceHeadingController.text = '';
      serviceDescriptionController.text = '';
    }
  }

  Future<void> editPortfolio() async {
    try {
      final portfolio = widget.portfolio!;

      // Keep existing images if no new ones are selected
      ProductImage? updatedProfilePicture =
          portfolio.personalInfo.profilePicture;
      ProductImage? updatedBannerImage = portfolio.personalInfo.bannerImage;
      ProductImage? updatedCompanyLogo = portfolio.workInfo.companyLogo;

      // Upload new images only if they are selected

      if (pickedProfileImage?.bytes != null) {
        try {
          final profileUploadResult = await PortfolioService.uploadImageFile(
            pickedProfileImage!.bytes!,
            pickedProfileImage!.name,
          );

          updatedProfilePicture = ProductImage(
            name: profileUploadResult['name'],
            key: profileUploadResult['key'],
            size: int.tryParse(profileUploadResult['size'].toString()),
            mimetype: profileUploadResult['mimetype'],
          );
        } catch (e) {
          logError('Error uploading profile: $e');
        }
      }
      if (pickedLogoImage?.bytes != null) {
        try {
          final logoUploadResult = await PortfolioService.uploadImageFile(
            pickedLogoImage!.bytes!,
            pickedLogoImage!.name,
          );

          updatedCompanyLogo = ProductImage(
            name: logoUploadResult['name'],
            key: logoUploadResult['key'],
            size: int.tryParse(logoUploadResult['size'].toString()),
            mimetype: logoUploadResult['mimetype'],
          );
        } catch (e) {
          logError('Error uploading logo: $e');
        }
      }

      if (pickedBannerImage?.bytes != null) {
        try {
          final bannerUploadResult = await PortfolioService.uploadImageFile(
            pickedBannerImage!.bytes!,
            pickedBannerImage!.name,
          );

          updatedBannerImage = ProductImage(
            name: bannerUploadResult['name'],
            key: bannerUploadResult['key'],
            size: int.tryParse(bannerUploadResult['size'].toString()),
            mimetype: bannerUploadResult['mimetype'],
          );
        } catch (e) {
          logError('Error uploading banner: $e');
        }
      }

      // Create the portfolio edit data
      final portfolioEditData = PortfolioDataModel(
        id: '',
        serviceHeading: serviceHeadController.text,
        personalInfo: PersonalInfo(
          profilePicture: updatedProfilePicture,
          bannerImage: updatedBannerImage,
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          whatsappNumber: whatsappNumberController.text,
        ),
        workInfo: WorkInfo(
          companyLogo: updatedCompanyLogo,
          companyName: companyNameController.text,
          designation: designationcontroller.text,
          workEmail: workemailController.text,
          primaryWebsite: primaryWebsiteController.text,
          secondaryWebsite: secondaryWebsiteController.text,
        ),
        addressInfo: AddressInfo(
          buildingName: buildingNamecontroller.text,
          area: areaController.text,
          pincode: pincodeController.text,
          district: districtController.text,
          state: stateController.text,
        ),
        about: About(
          heading: headingcontroller.text,
          description: descriptioncontroller.text,
        ),
        user: UserInfo(
          id: '',
          code: portfolio.user.code,
          isPremium: portfolio.user.isPremium,
        ),
        socialMedia: List<SocialMedia>.from(theFetchedPortfolio!.socialMedia),
        services: List<Service>.from(
          theFetchedPortfolio!.services.map(
            (service) => Service(
              id: service.id,
              heading: serviceHeadingController.text,
              description: serviceDescriptionController.text,
            ),
          ),
        ),
      );

      // Send the update request
      final response = await PortfolioService.editPortfolio(
        userid: widget.user.id,
        portfolioEditedData: portfolioEditData.toJson(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Portfolio updated successfully')),
        );
      }
    } catch (e) {
      logError('Error editing portfolio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update portfolio. Please try again.'),
          ),
        );
      }
    }
  }

  bool isLoading = false;

  Future<void> addServiceToPortfolio() async {
    setState(() {
      isLoading = true;
    });

    try {
      final portfolio = widget.portfolio;
      if (portfolio == null) return;

      if (serviceHeadingController.text.trim().isEmpty ||
          serviceDescriptionController.text.trim().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please fill in both fields')));
        return;
      }

      final serviceData = {
        'heading': serviceHeadingController.text.trim(),
        'description': serviceDescriptionController.text.trim(),
      };
      logInfo('Service Data: $serviceData');

      final response = await PortfolioService.addService(
        userId: widget.user.id,
        portfolioId: portfolio.id,
        serviceData: serviceData,
      );

      setState(() {
        portfolio.services.add(
          Service(
            id: '',
            heading: serviceHeadingController.text,
            description: serviceDescriptionController.text,
          ),
        );
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Service added successfully')));

      // Clear fields after successful addition
      serviceHeadingController.clear();
      serviceDescriptionController.clear();
    } catch (e) {
      print('Error adding service to portfolio: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add service')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> editService(Service serviceToEdit) async {
    try {
      final response = await PortfolioService.editService(
        serviceId: serviceToEdit.id!,
        editServiceData: {
          'heading': serviceHeadingController.text.trim(),
          'description': serviceDescriptionController.text.trim(),
        },
      );

      // Optionally update local state if needed
      setState(() {
        final index = widget.portfolio!.services.indexWhere(
          (s) => s.id == serviceToEdit.id,
        );
        if (index != -1) {
          widget.portfolio!.services[index] = Service(
            id: serviceToEdit.id,
            heading: serviceHeadingController.text,
            description: serviceDescriptionController.text,
          );
        }
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Service updated successfully')));
    } catch (e) {
      print('Error editing service: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update service')));
    }
  }

  void pickProfileImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          pickedProfileImage = result.files.first;
          previewProfileBytes = pickedProfileImage!.bytes;
        });

        // if (pickedProfileImage?.bytes != null) {
        //   final uploadResult = await PortfolioService.uploadImageFile(
        //     pickedProfileImage!.bytes!,
        //     pickedProfileImage!.name,
        //   );
        //   logInfo('Upload success: $uploadResult');
        // }
      }
    } catch (e) {
      logError('Error picking or uploading profile image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading profile image: $e')),
        );
      }
    }
  }

  // void pickImage() async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowedExtensions: ['jpg', 'jpeg', 'png'],
  //       withData: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       setState(() {
  //         pickedImage = result.files.first;
  //         previewImageBytes = pickedImage!.bytes; // Store the bytes for preview
  //       });

  //       // Upload the image file after picking it
  //       if (pickedImage?.bytes != null) {
  //         final uploadResult = await PortfolioService.uploadImageFile(
  //           pickedImage!.bytes!,
  //           pickedImage!.name,
  //         );

  //         logInfo('Upload success: $uploadResult');
  //       }
  //     } else {
  //       logInfo('No image selected.');
  //     }
  //   } catch (e) {
  //     logError('Error picking or uploading image: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
  //     }
  //   }
  // }
  // void pickImage() async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowedExtensions: ['jpg', 'jpeg', 'png'],
  //       withData: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       setState(() {
  //         pickedImage = result.files.first;
  //       });

  //       // Upload the image file after picking it
  //       final uploadResult = await PortfolioService.uploadImageFile(
  //         pickedImage!.bytes!, // image data as Uint8List
  //         pickedImage!.name, // filename with extension
  //       );

  //       // You can do something with uploadResult here
  //       logInfo('Upload result: $uploadResult');
  //       // Or update UI / state with uploaded info
  //     } else {
  //       logInfo('No image selected.');
  //     }
  //   } catch (e) {
  //     logError('Error picking or uploading image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(CustomPadding.paddingLarge.v),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MiniLoadingButton(
                  icon: Icons.save,
                  text: 'Save',

                  onPressed: () async {
                    await editPortfolio();
                    // await Future.wait([
                    //   editPortfolio(),
                    //   addServiceToPortfolio(),
                    // ]);

                    if (!mounted) return;
                    widget.onCallFunction();

                    Navigator.pop(context);
                    // updatePortfolio();

                    // popUpMessage(context);
                  },

                  useGradient: true,
                  gradientColors: CustomColors.borderGradient.colors,
                ),
                Gap(CustomPadding.paddingLarge.v),
                MiniGradientBorderButton(
                  text: 'Back',
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  gradient: LinearGradient(
                    colors: CustomColors.borderGradient.colors,
                  ),
                ),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),
            Gap(CustomPadding.paddingLarge.v),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge,
              ),
              child: Row(
                children: [
                  UserProfileContainer(
                    previewImageBytes: previewProfileBytes,
                    onTapEdit: pickProfileImage,
                    imageUrl: widget.portfolio?.personalInfo
                        .getProfilePictureUrl(baseUrl),

                    isEdit: true,
                    user: widget.user,
                    onPremiumChanged: (value) => setState(() {}),
                  ),
                  Gap(CustomPadding.paddingXL.v),
                  BasicDetailContainer(
                    autofocus: false,
                    // initialValue: widget.portfolio!.personalInfo.name,
                    namecontroller: nameController,
                    emailController: emailController,
                    whatsappController: whatsappNumberController,
                    phoneController: phoneNumberController,

                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge,
              ),
              child: Row(
                children: [
                  ProfileContainer(
                    designationController: designationcontroller,
                    companyController: companyNameController,
                    workEmailController: workemailController,
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                  Gap(CustomPadding.paddingXL.v),

                  LocationContainer(
                    buildingNamecontroller: buildingNamecontroller,
                    areaController: areaController,
                    pincodeController: pincodeController,
                    districtController: districtController,
                    stateController: stateController,
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  AdditionalContainer(
                    logoImageUrl: widget.portfolio?.workInfo.getCompanyLogoUrl(
                      baseUrl,
                    ),
                    bannerImageUrl: widget.portfolio?.personalInfo
                        .getBannerImageUrl(baseUrl),
                    primaryWebsiteController: primaryWebsiteController,
                    secondaryWebsiteController: secondaryWebsiteController,
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                    onLogoSelected: (file) {
                      setState(() {
                        pickedLogoImage = file;
                        previewLogoBytes = file.bytes;
                      });
                    },
                    onBannerSelected: (file) {
                      setState(() {
                        pickedBannerImage = file;
                        previewBannerBytes = file.bytes;
                      });
                    },
                  ),

                  // AdditionalContainer(
                  //   logoImageUrl: widget.portfolio?.workInfo.getCompanyLogoUrl(
                  //     baseUrl,
                  //   ),
                  //   bannerImageUrl: widget.portfolio?.personalInfo
                  //       .getBannerImageUrl(baseUrl),
                  //   primaryWebsiteController: primaryWebsiteController,
                  //   secondaryWebsiteController: secondaryWebsiteController,
                  //   user: widget.user,
                  //   isEdit: true,
                  //   portfolio: widget.portfolio,
                  // ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  SocialContainer(
                    isEdit: true,
                    user: widget.user,
                    portfolio: widget.portfolio,
                    onLinksChanged: (updatedLinks) {
                      setState(() {
                        socialLinks =
                            updatedLinks
                                .map(
                                  (link) => SocialMedia(
                                    id: link.id,
                                    source: link.source,
                                    link: link.link,
                                  ),
                                )
                                .toList();
                      });
                    },
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  //TODO : add textformfield scrollable
                  AboutContainer(
                    aboutHeadingController: headingcontroller,
                    aboutDescriptionController: descriptioncontroller,
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                ],
              ),
            ),

            Gap(CustomPadding.paddingXL.v),
            PaddingRow(
              children: [
                ExpandTileContainer(
                  title: 'Your Services',
                  children: [
                    TextFormContainer(labelText: 'Heading/Topic'),
                    Gap(CustomPadding.paddingLarge.v),
                    Divider(endIndent: 20, indent: 20, thickness: 1),
                    Gap(CustomPadding.paddingLarge.v),

                    Row(
                      children: [
                        Gap(CustomPadding.paddingLarge.v),
                        AddImageContainer(
                          imageUrl: null,
                          initialImage: null,
                          onImageSelected: (ProductImage? image) {
                            setState(() {
                              pickedServiceImage = image;
                            });
                          },
                        ),
                      ],
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                    TextFormContainer(
                      labelText: 'Heading/Topic',
                      controller: serviceHeadingController,
                    ),
                    TextFormContainer(
                      labelText: 'Description',
                      maxline: 7,
                      controller: serviceDescriptionController,
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MiniLoadingButton(
                          icon: Icons.save,
                          text: 'Save',
                          onPressed: () {},
                          useGradient: true,
                          gradientColors: CustomColors.borderGradient.colors,
                        ),
                        Gap(CustomPadding.paddingLarge.v),
                      ],
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                  ],
                ),
              ],
            ),
            Gap(CustomPadding.paddingXL.v),
          ],
        ),
      ),
    );
  }
}
