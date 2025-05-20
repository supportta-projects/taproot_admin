import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_about_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_additional_details.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_basicdetail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_social_media_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_user_location.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_user_profile.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/padding_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddUserPortfolio extends StatefulWidget {
  static const path = '/addUserPortfolio';
  const AddUserPortfolio({super.key, required this.user});
  final User user;

  // final dynamic user;

  @override
  State<AddUserPortfolio> createState() => _AddUserPortfolioState();
}

class _AddUserPortfolioState extends State<AddUserPortfolio> {
  late final User user;

  bool _isLoading = false;
  bool _isPremium = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController workEmailController = TextEditingController();
  final TextEditingController primaryWebsiteController =
      TextEditingController();
  final TextEditingController secondaryWebsiteController =
      TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController aboutHeadingController = TextEditingController();
  final TextEditingController serviceHeadController = TextEditingController();

  final TextEditingController aboutDescriptionController =
      TextEditingController();
  final TextEditingController serviceHeadingController =
      TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<SocialMedia> socialLinks = [];
  PlatformFile? pickedProfileImage;
  PlatformFile? pickedLogoImage;
  PlatformFile? pickedBannerImage;
  Uint8List? previewProfileBytes;
  Uint8List? previewLogoBytes;
  Uint8List? previewBannerBytes;

  List<Service> services = [];
  // PlatformFile? pickedServiceImage;
  Uint8List? previewServiceBytes;
  ProductImage? pickedServiceImage;
  String? imageUrl;

  @override
  void initState() {
    user = widget.user;
    _isPremium = user.isPremium;
    // TODO: implement initState
    super.initState();
  }

  Future<void> _addPortfolio() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      ProductImage? profilePicture;
      ProductImage? bannerImage;
      ProductImage? companyLogo;
      // Upload profile image if selected
      if (pickedProfileImage?.bytes != null) {
        final profileUploadResult = await PortfolioService.uploadImageFile(
          pickedProfileImage!.bytes!,
          pickedProfileImage!.name,
        );

        profilePicture = ProductImage(
          name: profileUploadResult['name'],
          key: profileUploadResult['key'],
          size: int.tryParse(profileUploadResult['size'].toString()),
          mimetype: profileUploadResult['mimetype'],
        );
      }

      // Upload logo if selected
      if (pickedLogoImage?.bytes != null) {
        final logoUploadResult = await PortfolioService.uploadImageFile(
          pickedLogoImage!.bytes!,
          pickedLogoImage!.name,
        );

        companyLogo = ProductImage(
          name: logoUploadResult['name'],
          key: logoUploadResult['key'],
          size: int.tryParse(logoUploadResult['size'].toString()),
          mimetype: logoUploadResult['mimetype'],
        );
      }

      // Upload banner if selected
      if (pickedBannerImage?.bytes != null) {
        final bannerUploadResult = await PortfolioService.uploadImageFile(
          pickedBannerImage!.bytes!,
          pickedBannerImage!.name,
        );

        bannerImage = ProductImage(
          name: bannerUploadResult['name'],
          key: bannerUploadResult['key'],
          size: int.tryParse(bannerUploadResult['size'].toString()),
          mimetype: bannerUploadResult['mimetype'],
        );
      }

      final portfolio = PortfolioDataModel(
        id: '',
        personalInfo: PersonalInfo(
          profilePicture: profilePicture,
          bannerImage: bannerImage,
          name: nameController.text,
          email: emailController.text,
          phoneNumber: '+91${phoneController.text}',
          whatsappNumber: '+91${whatsappController.text}',
        ),
        workInfo: WorkInfo(
          companyLogo: companyLogo,
          companyName: companyController.text,
          designation: designationController.text,
          workEmail: workEmailController.text,
          primaryWebsite: primaryWebsiteController.text,
          secondaryWebsite: secondaryWebsiteController.text,
        ),
        addressInfo: AddressInfo(
          buildingName: buildingController.text,
          area: areaController.text,
          pincode: pincodeController.text,
          district: districtController.text,
          state: stateController.text,
        ),
        about: About(
          heading: aboutHeadingController.text,
          description: aboutDescriptionController.text,
        ),
        user: UserInfo(id: user.id, code: user.userId, isPremium: true),
        socialMedia: socialLinks,
        serviceHeading: serviceHeadController.text,
        services: [],
      );

      final portfolioData = portfolio.toJson();
      final result = await PortfolioService.postPortfolio(
        userid: user.id,
        portfolioData: portfolioData,
      );
      if (mounted) {
        if (result != null) {
          // Show success message, or navigate to another screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Portfolio added successfully!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to add portfolio.')));
        }
      }
    } catch (e) {
      logError('User: ${user.id}, ${user.userId}');
      logError(e);

      final message = e is CustomException ? e.message : 'Fill Correct Details';
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // void handleServiceSave() async {
  //   if (serviceHeadingController.text.isEmpty ||
  //       serviceDescriptionController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please fill all service details')),
  //     );
  //     return;
  //   }

  //   ProductImage? serviceImage;
  //   if (pickedServiceImage?.bytes != null) {
  //     try {
  //       final uploadResult = await PortfolioService.uploadImageFile(
  //         pickedServiceImage!.bytes!,
  //         pickedServiceImage!.name,
  //       );

  //       serviceImage = ProductImage(
  //         name: uploadResult['name'],
  //         key: uploadResult['key'],
  //         size: int.tryParse(uploadResult['size'].toString()),
  //         mimetype: uploadResult['mimetype'],
  //       );
  //     } catch (e) {
  //       logError('Error uploading service image: $e');
  //     }
  //   }

  //   setState(() {
  //     services.add(
  //       Service(
  //         heading: serviceHeadingController.text,
  //         description: serviceDescriptionController.text,
  //         image: serviceImage,
  //       ),
  //     );
  //     serviceHeadingController.clear();
  //     serviceDescriptionController.clear();
  //     pickedServiceImage = pickedServiceImage;
  //     previewServiceBytes = previewServiceBytes;
  //   });
  // }

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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    companyController.dispose();
    designationController.dispose();
    workEmailController.dispose();
    primaryWebsiteController.dispose();
    secondaryWebsiteController.dispose();
    buildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    districtController.dispose();
    stateController.dispose();
    aboutHeadingController.dispose();
    aboutDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gap(CustomPadding.paddingLarge.v),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MiniLoadingButton(
                    isLoading: _isLoading,
                    icon: Icons.add,
                    text: 'Add',
                    onPressed: () {
                      _isLoading ? null : _addPortfolio();
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
              Gap(CustomPadding.paddingXL.v),

              PaddingRow(
                children: [
                  UserProfileContainer(
                    imageUrl: null,
                    previewImageBytes: previewProfileBytes,
                    onTapEdit: pickProfileImage,
                    user: user,
                    isEdit: true,
                    onPremiumChanged:
                        (value) => setState(() {
                          _isPremium = value;
                        }),
                  ),
                  Gap(CustomPadding.paddingXL.v),

                  AddBasicDetailContainer(
                    namecontroller: nameController,
                    emailcontroller: emailController,
                    phonecontroller: phoneController,
                    whatsappcontroller: whatsappController,
                  ),
                ],
              ),
              Gap(CustomPadding.paddingLarge.v),
              PaddingRow(
                children: [
                  AddUserProfile(
                    designataioncontroller: designationController,
                    companycontroller: companyController,
                    workemailcontroller: workEmailController,
                  ),
                  Gap(CustomPadding.paddingXL.v),
                  AddUserLocation(
                    user: user,
                    buildingcontroller: buildingController,
                    areacontroller: areaController,
                    pincodecontroller: pincodeController,
                    districtcontroller: districtController,
                    statecontroller: stateController,
                  ),
                ],
              ),
              Gap(CustomPadding.paddingLarge.v),
              PaddingRow(
                children: [
                  AddAdditionalDetails(
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
                    primaryWebsitecontroller: primaryWebsiteController,
                    secondaryWebsitecontroller: secondaryWebsiteController,
                  ),
                ],
              ),
              Gap(CustomPadding.paddingXL.v),
              PaddingRow(
                children: [
                  AddSocialMediaContainer(
                    user: user,
                    onLinksChanged: (newLinks) {
                      setState(() {
                        socialLinks = newLinks; // Update the social media list
                      });
                    },
                  ),
                ],
              ),
              Gap(CustomPadding.paddingXL.v),
              PaddingRow(
                children: [
                  AddAboutContainer(
                    user: user,
                    headingcontroller: aboutHeadingController,
                    descriptioncontroller: aboutDescriptionController,
                  ),
                ],
              ),
              Gap(CustomPadding.paddingXL.v),
              // PaddingRow(
              //   children: [
              //     ExpandTileContainer(
              //       title: 'Your Services',
              //       children: [
              //         TextFormContainer(labelText: 'Heading/Topic'),
              //         Gap(CustomPadding.paddingLarge.v),
              //         Divider(endIndent: 20, indent: 20, thickness: 1),
              //         Gap(CustomPadding.paddingLarge.v),

              //         Row(
              //           children: [
              //             Gap(CustomPadding.paddingLarge.v),
              //             AddImageContainer(
              //               imageUrl: null,
              //               initialImage: null,
              //               onImageSelected: (ProductImage? image) {
              //                 setState(() {
              //                   pickedServiceImage = image;
              //                 });
              //               },
              //             ),
              //           ],
              //         ),
              //         Gap(CustomPadding.paddingLarge.v),
              //         TextFormContainer(
              //           labelText: 'Heading/Topic',
              //           controller: serviceHeadingController,
              //         ),
              //         TextFormContainer(
              //           labelText: 'Description',
              //           maxline: 7,
              //           controller: serviceDescriptionController,
              //         ),
              //         Gap(CustomPadding.paddingLarge.v),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             MiniLoadingButton(
              //               icon: Icons.save,
              //               text: 'Save',
              //               onPressed: () {},
              //               useGradient: true,
              //               gradientColors: CustomColors.borderGradient.colors,
              //             ),
              //             Gap(CustomPadding.paddingLarge.v),
              //           ],
              //         ),
              //         Gap(CustomPadding.paddingLarge.v),
              //       ],
              //     ),
              //   ],
              // ),
              // PaddingRow(
              //   children: [
              //     ServiceContainer(
              //       isEdited: true,
              //       user: user,
              //       serviceHeadingController: serviceHeadingController,
              //       serviceDescriptionController: serviceDescriptionController,
              //       saveButton: handleServiceSave,
              //       onImageSelected: (file) {
              //         setState(() {
              //           pickedServiceImage = file;
              //           previewServiceBytes = file.bytes;
              //         });
              //       },
              //       services: services, // Pass the services list
              //     ),
              //   ],
              // ),
              Gap(CustomPadding.paddingXXL.v),
            ],
          ),
        ),
      ),
    );
  }
}

class AddImageContainer extends StatefulWidget {
  final ProductImage? initialImage;
  final Function(ProductImage?) onImageSelected;
  final String? imageUrl;
  final String baseUrl;
  const AddImageContainer({
    super.key,
    this.imageUrl,
    required this.onImageSelected,
    this.initialImage,
    required this.baseUrl,
  });

  @override
  State<AddImageContainer> createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  PlatformFile? pickedFile;
  Uint8List? previewBytes;
  bool isUploading = false;
  ProductImage? currentImage;

  @override
  void initState() {
    super.initState();
    currentImage = widget.initialImage;
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          pickedFile = result.files.first;
          previewBytes = pickedFile!.bytes;
          currentImage = null;
        });

        await uploadFile();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  Future<void> uploadFile() async {
    if (pickedFile?.bytes == null) return;

    setState(() {
      isUploading = true;
    });

    try {
      final result = await PortfolioService.uploadServiceImageFile(
        pickedFile!.bytes!,
        pickedFile!.name,
      );

      final productImage = ProductImage(
        name: pickedFile!.name,
        key: result['key'],
        size: pickedFile!.size,
        mimetype: 'image/${pickedFile!.extension}',
      );

      setState(() {
        currentImage = productImage;
        pickedFile = null; // Clear picked file
        previewBytes = null; // Clear preview bytes
        isUploading = false;
      });

      widget.onImageSelected(productImage);
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    }
  }

  Widget _buildPreview() {
    // Show uploaded image if available
    if (currentImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              '${widget.baseUrl}/file?key=portfolios/portfolio_services/${currentImage!.key}', // Use direct URL
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                print('Image Error: $error'); // Debug print
                return const Center(child: Icon(Icons.error));
              },
            ),
          ),
          _buildRemoveButton(),
        ],
      );
    }

    // Show preview while uploading
    if (previewBytes != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.memory(
              previewBytes!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (isUploading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          _buildRemoveButton(),
        ],
      );
    }

    // Show add icon if no image
    return Center(child: SvgPicture.asset(Assets.svg.addround));
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: 5,
      right: 5,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () {
          setState(() {
            pickedFile = null;
            previewBytes = null;
            currentImage = null;
          });
          widget.onImageSelected(null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickFile,
      child: Container(
        width: 190.v,
        height: 160.v,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge.v),
          color: CustomColors.lightGreen,
        ),
        child: _buildPreview(),
      ),
    );
  }
}
