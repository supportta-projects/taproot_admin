import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/user_profile_container.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';

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
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                  Gap(CustomPadding.paddingXL.v),
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
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
                children: [CommonUserContainer(title: 'Social Media ')],
              ),
            ),

            // Add your form fields here
          ],
        ),
      ),
    );
  }
}
