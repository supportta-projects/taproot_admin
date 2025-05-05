import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/extensions/font_extension.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class AboutContainer extends StatelessWidget {
  final PortfolioDataModel? portfolio;
  final bool isEdit;
  const AboutContainer({
    this.isEdit = false,
    super.key,
    required this.user,
    this.portfolio,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? ExpandTileContainer(
          title: 'About',
          children: [
            TextFormContainer(
              initialValue: 'About me',
              labelText: 'Heading/topic',
              user: user,
            ),
            TextFormContainer(
              maxline: 8,
              initialValue: loremIpsum,
              labelText: 'Description',
              user: user,
            ),
          ],
        )
        : CommonUserContainer(
          title: 'About',
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(CustomPadding.paddingLarge),
                  Text(portfolio!.about.heading, style: context.inter50016),
                  Gap(CustomPadding.paddingLarge),
                  Text(portfolio!.about.description, maxLines: 8),
                ],
              ),
            ),
          ],
        );
  }
}
