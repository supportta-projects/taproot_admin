import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class LocationContainer extends StatelessWidget {
  final bool isEdit;
  const LocationContainer({super.key, required this.user, this.isEdit = false});
  final User user;

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Location',
      children:
          isEdit
              ? [
                Gap(CustomPadding.paddingLarge.v),
                TextFormContainer(
                  initialValue: '3rd floor CSI Complex',
                  labelText: 'Building Name',
                  user: user,
                ),
                TextFormContainer(
                  initialValue: 'Baker Junction',
                  labelText: 'Area',
                  user: user,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormContainer(
                        initialValue: '123456',
                        labelText: 'Pin code',
                        user: user,
                      ),
                    ),
                    Expanded(
                      child: TextFormContainer(
                        initialValue: '123456',
                        labelText: 'Pin code',
                        user: user,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormContainer(
                        initialValue: 'Kerala',
                        labelText: 'State',
                        user: user,
                      ),
                    ),
                    Expanded(
                      child: TextFormContainer(
                        initialValue: 'India',
                        labelText: 'Country',
                        user: user,
                      ),
                    ),
                  ],
                ),
              ]
              : [
                Gap(CustomPadding.paddingLarge.v),

                DetailRow(
                  label: 'Building Name',
                  value: '3rd floor CSI Complex',
                ),
                DetailRow(label: 'Area', value: 'Baker Junction'),
                DetailRow(label: 'Pin code', value: '123456'),
                DetailRow(label: 'District', value: 'Kottayam'),
                DetailRow(label: 'State', value: 'Kerala'),
                DetailRow(label: 'Country', value: 'India'),
              ],
    );
  }
}
