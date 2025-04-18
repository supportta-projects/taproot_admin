import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';

class ProfileContainer extends StatelessWidget {
  final bool isEdit;
  const ProfileContainer({super.key, required this.user, this.isEdit = false});

  final User user;

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Profile',
      children: [
        Gap(CustomPadding.paddingLarge.v),
        isEdit
            ? TextFormContainer(
              initailValue: 'Founder- Supportta Solutions',
              labelText: 'Designation',
              user: user,
            )
            : DetailRow(
              label: 'Designation',
              value: 'Founder- Supportta Solutions',
            ),
        isEdit
            ? TextFormContainer(
              readonly: true,
              initailValue: 'Supportta Solutions Private Limited',
              labelText: 'Company Name',
              user: user,
            )
            : DetailRow(
              label: 'Company Name',
              value: 'Supportta Solutions Private Limited',
            ),
        isEdit
            ? TextFormContainer(
              user: user,
              initailValue: user.email,
              labelText: 'Email',
            )
            : DetailRow(label: 'Email', value: user.email),
      ],
    );
  }
}
