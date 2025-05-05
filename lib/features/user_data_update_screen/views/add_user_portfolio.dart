import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddUserPortfolio extends StatefulWidget {
  const AddUserPortfolio({super.key, required this.user});
  final User user;
  // final dynamic user;

  @override
  State<AddUserPortfolio> createState() => _AddUserPortfolioState();
}

class _AddUserPortfolioState extends State<AddUserPortfolio> {
  late final User user;
  bool _isLoading = false;

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
  final TextEditingController aboutDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<SocialMedia> socialLinks = [];
  @override
  void initState() {
    user = widget.user;
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
      final portfolio = PortfolioDataModel(
        id: '',
        personalInfo: PersonalInfo(
          name: nameController.text,
          email: emailController.text,
          phoneNumber: '+91${phoneController.text}',
          whatsappNumber: '+91${whatsappController.text}',
        ),
        workInfo: WorkInfo(
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
        user: UserInfo(id: user.id, code: user.userId, isPremium: false),
        socialMedia: socialLinks,
        services: [],
      );

      final portfolioData = portfolio.toJson();
      final result = await PortfolioService.postPortfolio(
        userid: user.id,
        portfolioData: portfolioData,
      );

      if (result != null) {
        // Show success message, or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Portfolio added successfully!')),
        );
      } else {
        // Handle failure, maybe show an error message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add portfolio.')));
      }
    } catch (e) {
      logError('User: ${user.id}, ${user.userId}');
      logError(e);
      // Handle any errors that occur during the API call
      // final message = e is CustomException ? e.message : e;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
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
                  UserProfileContainer(user: user, isEdit: true),
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
              Gap(CustomPadding.paddingXXL.v),
              Gap(CustomPadding.paddingXXL.v),
            ],
          ),
        ),
      ),
    );
  }
}
