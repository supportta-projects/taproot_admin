import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_card.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';

class ServiceContainer extends StatelessWidget {
  final bool isEdited;
  const ServiceContainer({
    this.isEdited = false,
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return isEdited
        ? ExpandTileContainer(
          title: 'Your Services',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormContainer(
                  initailValue: 'About me',
                  labelText: 'Heading/topic',
                  user: user,
                ),
                Gap(CustomPadding.padding.v),
                Padding(
                  padding: EdgeInsets.only(left: CustomPadding.paddingLarge),
                  child: ServiceCard(
                    isEdited: isEdited,
                    title: 'Service',
                    description: loremIpsum,
                  ),
                ),
              ],
            ),
          ],
        )
        : CommonUserContainer(
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
        );
  }
}
