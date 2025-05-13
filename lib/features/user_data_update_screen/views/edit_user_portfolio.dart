import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/about_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/additional_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/padding_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/profile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_container.dart';
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

    nameController.text = theFetchedPortfolio!.personalInfo.name;
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
      serviceHeadingController.text = theFetchedPortfolio!.services[0].heading;
      serviceDescriptionController.text =
          theFetchedPortfolio!.services[0].description;
    } else {
      // Initialize with empty strings if no services exist
      serviceHeadingController.text = '';
      serviceDescriptionController.text = '';
    }
  }

  // void updatePortfolio() {
  Future<void> editPortfolio() async {
    try {
      final portfolio = widget.portfolio!;
      final portfolioEditData = PortfolioDataModel(
        id: portfolio.id,
        personalInfo: PersonalInfo(
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          whatsappNumber: whatsappNumberController.text,
        ),
        workInfo: WorkInfo(
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
      final response = await PortfolioService.editPortfolio(
        userid: widget.user.id,
        portfolioEditedData: portfolioEditData.toJson(),
      );
    } catch (e) {}
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
                    isEdit: false,
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
                    primaryWebsiteController: primaryWebsiteController,
                    secondaryWebsiteController: secondaryWebsiteController,
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
            // PaddingRow(
            //   children: [
            //       ServiceContainer(
            //       serviceHeadingController: serviceHeadingController,
            //       serviceDescriptionController: serviceDescriptionController,
            //       portfolio: widget.portfolio,
            //       isEdited: true,
            //       user: widget.user,
            //       onServiceAdd: addServiceToPortfolio,
            //       onServiceEdit: editService,
            //       onServiceDelete: (p0) {
                    
            //       },
            //     ),
            //   ],
            // ),
            Gap(CustomPadding.paddingXL.v),
          ],
        ),
      ),
    );
  }
}
