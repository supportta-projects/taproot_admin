import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class LocationContainer extends StatelessWidget {
  final PortfolioDataModel? portfolio;
  final bool isEdit;
  const LocationContainer({
    super.key,
    required this.user,
    this.isEdit = false,
    this.portfolio,
  });
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
                  initialValue: portfolio!.addressInfo. buildingName,
                  labelText: 'Building Name',
                  user: user,
                ),
                TextFormContainer(
                  initialValue: portfolio!.addressInfo. area,
                  labelText: 'Area',
                  user: user,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormContainer(
                        initialValue: portfolio!.addressInfo.pincode,
                        labelText: 'Pin code',
                        user: user,
                      ),
                    ),
                    Expanded(
                      child: TextFormContainer(
                        initialValue: portfolio!.addressInfo.district,
                        labelText: 'District',
                        user: user,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormContainer(
                        initialValue: portfolio!.addressInfo.state,
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
                  value: portfolio?.addressInfo.buildingName ?? 'Loading...',
                ),
                DetailRow(
                  label: 'Area',
                  value: portfolio?.addressInfo.area ?? 'Loading...',
                ),
                DetailRow(
                  label: 'Pin code',
                  value: portfolio?.addressInfo.pincode ?? 'Loading...',
                ),
                DetailRow(
                  label: 'District',
                  value: portfolio?.addressInfo.district ?? 'Loading...',
                ),
                DetailRow(
                  label: 'State',
                  value: portfolio?.addressInfo.state ?? 'Loading...',
                ),
                DetailRow(label: 'Country', value: 'India'),
              ],
    );
  }
}
