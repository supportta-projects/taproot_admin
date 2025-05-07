import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/additional_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/profile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class EditUserPortfolio extends StatefulWidget {
  final PortfolioDataModel? portfolio;

  final User user;
  const EditUserPortfolio({
    super.key,
    required this.user,
    required this.portfolio,
  });

  @override
  State<EditUserPortfolio> createState() => _EditUserPortfolioState();
}

class _EditUserPortfolioState extends State<EditUserPortfolio> {
  Future<void> editPortfolio() async {
    try {
      final portfolio = widget.portfolio!;
      final portfolioEditData = PortfolioDataModel(
        id: '',
        personalInfo: PersonalInfo(
          name: portfolio.personalInfo.name,
          email: portfolio.personalInfo.email,
          phoneNumber: portfolio.personalInfo.phoneNumber,
          whatsappNumber: portfolio.personalInfo.whatsappNumber,
          profileImage: '',
          bannerImage: '',
        ),
        workInfo: WorkInfo(
          companyName: portfolio.workInfo.companyName,
          designation: portfolio.workInfo.designation,
          workEmail: portfolio.workInfo.workEmail,
          primaryWebsite: portfolio.workInfo.primaryWebsite,
          secondaryWebsite: portfolio.workInfo.secondaryWebsite,
        ),
        addressInfo: portfolio.addressInfo,
        about: portfolio.about,
        user: portfolio.user,
        socialMedia: portfolio.socialMedia,
        services: portfolio.services,
      );
      final response = await PortfolioService.editPortfolio(
        userid: widget.user.id,
        portfolioEditedData: portfolioEditData.toJson(),
      );
    } catch (e) {}
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
                    // You might want to give feedback or navigate back
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Portfolio updated successfully!'),
                      ),
                    );
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
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                  Gap(CustomPadding.paddingXL.v),

                  LocationContainer(
                    user: widget.user,
                    isEdit: true,
                    portfolio: widget.portfolio,
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: CustomPadding.paddingLarge.v,
            //   ),
            //   child: Row(
            //     children: [
            //       AdditionalContainer(
            //         user: widget.user,
            //         isEdit: true,
            //         portfolio: widget.portfolio,
            //       ),
            //     ],
            //   ),
            // ),
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
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: CustomPadding.paddingLarge.v,
            //   ),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         AboutContainer(
            //           user: widget.user,
            //           isEdit: true,
            //           portfolio: widget.portfolio,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
