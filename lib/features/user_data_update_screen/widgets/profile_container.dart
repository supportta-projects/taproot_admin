import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class ProfileContainer extends StatelessWidget {
  final PortfolioDataModel? portfolio;

  final bool isEdit;
  const ProfileContainer({
    super.key,
    required this.user,
    this.isEdit = false,
    this.portfolio,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Profile',
      children: [
        Gap(CustomPadding.paddingLarge.v),
        isEdit
            ? TextFormContainer(
              initialValue: portfolio!.designation ,
              labelText: 'Designation',
              user: user,
            )
            : DetailRow(
              label: 'Designation',
              value: portfolio?.designation ?? 'loading...',
            ),
        isEdit
            ? TextFormContainer(
              readonly: true,
              initialValue: portfolio!.companyName,
              labelText: 'Company Name',
              user: user,
            )
            : DetailRow(
              label: 'Company Name',
              value: portfolio?.companyName ?? 'loading...',
            ),
        isEdit
            ? TextFormContainer(
              user: user,
              initialValue: portfolio!.email,
              labelText: 'Email',
            )
            : DetailRow(label: 'Email', value: portfolio?.email ?? ' loading...'),
      ],
    );
  }
}
