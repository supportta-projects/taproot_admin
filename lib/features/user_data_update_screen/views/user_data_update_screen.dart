import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_card.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_image.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/social_media_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';

class UserDataUpdateScreen extends StatefulWidget {
  final dynamic user;

  static const path = '/userDataUpdateScreen';
  const UserDataUpdateScreen({super.key, required this.user});

  @override
  State<UserDataUpdateScreen> createState() => _UserDataUpdateScreenState();
}

class _UserDataUpdateScreenState extends State<UserDataUpdateScreen> {
  late final User user;
  @override
  void initState() {
    user = widget.user;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },

              child: Text('Click here to go back to the previous screen'),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge,
              ),
              child: Row(
                children: [
                  UserProfileContainer(),
                  Gap(CustomPadding.paddingXL.v),
                  CommonUserContainer(
                    title: 'Basic Details',
                    children: [
                      Gap(CustomPadding.paddingLarge.v),
                      DetailRow(label: 'Full Name', value: user.fullName),
                      DetailRow(label: 'Email', value: user.email),
                      DetailRow(label: 'Phone Number', value: user.phone),
                      DetailRow(label: 'WhatsApp Number', value: user.whatsapp),
                    ],
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
                  CommonUserContainer(
                    title: 'Profile',
                    children: [
                      Gap(CustomPadding.paddingLarge.v),

                      DetailRow(
                        label: 'Designation',
                        value: 'Founder- Supportta Solutions',
                      ),
                      DetailRow(
                        label: 'Company Name',
                        value: 'Supportta Solutions Private Limited',
                      ),
                      DetailRow(label: 'Phone Number', value: user.phone),
                    ],
                  ),
                  Gap(CustomPadding.paddingXL.v),

                  CommonUserContainer(
                    title: 'Location',
                    children: [
                      Gap(CustomPadding.paddingLarge.v),

                      DetailRow(
                        label: 'Building Name',
                        value: '3rd floor CSI Complex',
                      ),
                      DetailRow(label: 'Area', value: 'Baker Junction'),
                      DetailRow(label: 'Pin code', value: '123456'),
                      DetailRow(label: 'Distict', value: 'Kottayam'),
                      DetailRow(label: 'State', value: 'Kerala'),
                      DetailRow(label: 'country', value: 'India'),
                    ],
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
                  CommonUserContainer(
                    height: SizeUtils.height * 0.35,
                    title: 'Additional Details',
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                DetailRow(label: 'Email', value: '-'),
                                DetailRow(
                                  label: 'Website Link',
                                  value: 'https://docs.google.com...',
                                ),
                                DetailRow(label: 'Website Link', value: '-'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: CustomPadding.paddingXL,
                              ),
                              child: Row(
                                children: [
                                  ImageContainer(title: 'Loco'),
                                  ImageContainer(title: 'Banner Image'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                  CommonUserContainer(
                    height: SizeUtils.height * 0.20,
                    title: 'Social Media ',
                    children: [
                      Padding(
                        padding: EdgeInsets.all(CustomPadding.paddingLarge.v),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SocialMediaContainer(
                              svg: Assets.svg.facebook,
                              name: 'Facebook',
                            ),
                            SocialMediaContainer(
                              svg: Assets.svg.instagram,
                              name: 'Instagram',
                            ),
                            SocialMediaContainer(
                              svg: Assets.svg.twitter,
                              name: 'Twitter',
                            ),
                            SocialMediaContainer(
                              svg: Assets.svg.behance,
                              name: 'Behance',
                            ),
                            SocialMediaContainer(
                              svg: Assets.svg.linkdin,
                              name: 'linkdIn',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(children: [CommonUserContainer(title: 'About')]),
            ),
            Gap(CustomPadding.paddingXL.v),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  CommonUserContainer(
                    height: SizeUtils.height * 0.45,
                    title: 'Your Services',
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomPadding.paddingXL.v,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(CustomPadding.paddingLarge.v),
                            Text('My Works', style: context.inter50016),
                            Gap(CustomPadding.paddingLarge.v),

                            ServiceCard(
                              title: 'Service',
                              description:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has",
                            ),
                          ],
                        ),
                      ),
                    ],
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
                  CommonUserContainer(
                    height: SizeUtils.height * 0.5,
                    title: 'Gallery',
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: CustomPadding.paddingXL.v,
                          left: CustomPadding.paddingLarge.v,
                        ),
                        child: Row(children: [Text('My Works')]),
                      ),
                      Gap(CustomPadding.paddingLarge.v),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomPadding.paddingXXL.v,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                          ],
                        ),
                      ),
                      Gap(CustomPadding.paddingLarge.v),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomPadding.paddingXXL.v,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                            ServiceImage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add your form fields here
          ],
        ),
      ),
    );
  }
}
