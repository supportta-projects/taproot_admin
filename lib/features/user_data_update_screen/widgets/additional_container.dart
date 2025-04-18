import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/services/size_utils.dart';

import '../../users_screen/user_data_model.dart';

class AdditionalContainer extends StatelessWidget {
  final bool isEdit;
  final User user;
  const AdditionalContainer({
    super.key,
    required this.user,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      height: SizeUtils.height * 0.35,
      title: 'Additional Details',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  isEdit
                      ? TextFormContainer(
                        initailValue: 'https://docs.google.com',
                        labelText: 'Website Link',
                        user: user,
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value: 'https://docs.google.com',
                      ),
                  isEdit
                      ? TextFormContainer(
                        initailValue: '-',
                        labelText: 'Website Link',
                        user: user,
                      )
                      : DetailRow(label: 'Website Link', value: '-'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: CustomPadding.paddingXL),
                child: Row(
                  children: [
                    ImageContainer(
                      isEdit: true,
                      title: 'Loco',
                      icon: LucideIcons.upload,
                      imageState: 'Upload',
                    ),
                    ImageContainer(
                      isEdit: true,
                      title: 'Banner Image',
                      icon: LucideIcons.repeat,
                      imageState: 'Replace',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
