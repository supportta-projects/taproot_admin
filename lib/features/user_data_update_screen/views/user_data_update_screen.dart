import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/views/add_user_portfolio.dart';
import 'package:taproot_admin/features/user_data_update_screen/views/edit_user_portfolio.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/about_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/profile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

import '../widgets/additional_container.dart';

class UserDataUpdateScreen extends StatefulWidget {
  final dynamic user;

  static const path = '/userDataUpdateScreen';
  const UserDataUpdateScreen({super.key, required this.user});

  @override
  State<UserDataUpdateScreen> createState() => _UserDataUpdateScreenState();
}

class _UserDataUpdateScreenState extends State<UserDataUpdateScreen> {
  PortfolioDataModel? portfolio;
  late final User user;
  bool isLoading = false;
  @override
  void initState() {
    user = widget.user;
    fetchPortfolio();
    // fetchPortfolio();
    // TODO: implement initState
    super.initState();
  }

  bool userEdit = false;
  void editUser() {
    setState(() {
      userEdit = !userEdit;
    });
  }

  Future fetchPortfolio() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await PortfolioService.getPortfolio(userid: user.id);

      if (result != null) {
        setState(() {
          portfolio = result;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        if (e is CustomException && e.statusCode == 404) {
          // Navigate to add user portfolio screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => AddUserPortfolio(user: user)),
          );

          // Navigator.pushReplacementNamed(
          //   context,
          //   '/addUserPortfolio',
          //   arguments: user,
          // );
        } else {
          logError(e.toString());
          // You can show a Snackbar or AlertDialog to inform the user
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        'Click here to go back to the previous screen',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingLarge,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'User  >  User Details',
                            style: context.inter60016.copyWith(
                              color: Colors.green,
                            ),
                          ),
                          Spacer(),
                          userEdit
                              ? MiniLoadingButton(
                                icon: Icons.save,
                                text: 'Save',
                                onPressed: () {},
                                useGradient: true,
                                gradientColors:
                                    CustomColors.borderGradient.colors,
                              )
                              : MiniLoadingButton(
                                icon: Icons.edit,
                                text: 'Edit',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => EditUserPortfolio(
                                            user: widget.user,
                                            portfolio: portfolio,
                                            onCallFunction:
                                                () => fetchPortfolio(),
                                          ),
                                    ),
                                  );
                                },
                                useGradient: true,
                                gradientColors:
                                    CustomColors.borderGradient.colors,
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

                          // MiniGradientBorderButton(
                          //   text: 'Back',
                          //   icon: Icons.arrow_back,
                          //   onPressed: () async {
                          //     if (userEdit) {
                          //       final shouldDiscard = await showDialog<bool>(
                          //         context: context,
                          //         builder:
                          //             (context) => AlertDialog(
                          //               title: const Text('Discard changes?'),
                          //               content: const Text(
                          //                 'You have unsaved changes. Are you sure you want to go back?',
                          //               ),
                          //               actions: [
                          //                 TextButton(
                          //                   onPressed:
                          //                       () => Navigator.of(context).pop(false),
                          //                   child: const Text('Cancel'),
                          //                 ),
                          //                 TextButton(
                          //                   onPressed:
                          //                       () => Navigator.of(context).pop(true),
                          //                   child: const Text('Discard'),
                          //                 ),
                          //               ],
                          //             ),
                          //       );
                          //       if (shouldDiscard == true) {
                          //         Navigator.pop(context);
                          //       }
                          //     } else {
                          //       Navigator.pop(context);
                          //     }
                          //   },
                          //   gradient: LinearGradient(
                          //     colors: CustomColors.borderGradient.colors,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Gap(CustomPadding.paddingLarge.v),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingLarge,
                      ),
                      child: Row(
                        children: [
                          UserProfileContainer(
                            imageUrl: portfolio?.personalInfo
                                .getProfilePictureUrl(baseUrl),
                            isEdit: userEdit,
                            user: user,
                            onPremiumChanged:
                                (value) => setState(() {
                                  user.isPremium = value;
                                }),
                          ),
                          Gap(CustomPadding.paddingXL.v),
                          BasicDetailContainer(
                            user: user,
                            isEdit: userEdit,
                            portfolio: portfolio,
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
                            user: user,
                            isEdit: userEdit,
                            portfolio: portfolio,
                          ),
                          Gap(CustomPadding.paddingXL.v),

                          LocationContainer(
                            user: user,
                            isEdit: userEdit,
                            portfolio: portfolio,
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
                            logoImageUrl: portfolio?.workInfo.getCompanyLogoUrl(
                              baseUrl,
                            ),
                            bannerImageUrl: portfolio?.personalInfo
                                .getBannerImageUrl(baseUrl),
                            user: user,
                            isEdit: userEdit,
                            portfolio: portfolio,
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
                            isEdit: userEdit,
                            user: user,
                            portfolio: portfolio,
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
                          AboutContainer(
                            user: user,
                            isEdit: userEdit,
                            portfolio: portfolio,
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
                    //       ServiceContainer(
                    //         isEdited: userEdit,
                    //         user: user,
                    //         portfolio: portfolio,
                    //         onServiceAdd: () async {
                    //           // Refresh the portfolio data after adding
                    //           await fetchPortfolio();
                    //         },
                    //         onServiceEdit: (Service service) async {
                    //           // Refresh the portfolio data after editing
                    //           await fetchPortfolio();
                    //         },
                    //         onServiceDelete: (String serviceId) async {
                    //           // Refresh the portfolio data after deleting
                    //           await fetchPortfolio();
                    //         },
                    //       ),

                    //     ],
                    //   ),
                    // ),
                    Gap(CustomPadding.paddingXXL.v),

                    // Add your form fields here
                  ],
                ),
              ),
    );
  }
}

//
