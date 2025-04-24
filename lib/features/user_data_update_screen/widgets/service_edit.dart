import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ServiceEdit extends StatelessWidget {
  const ServiceEdit({super.key, required this.widget});

  final ServiceContainer widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddImageContainer(),
        Gap(CustomPadding.paddingLarge.v),

        TextFormContainer(
          initialValue: 'About me',
          labelText: 'Heading/topic',
          user: widget.user,
        ),
        Gap(CustomPadding.paddingLarge.v),
        TextFormContainer(
          maxline: 4,
          initialValue: loremIpsum,
          labelText: 'Description',
          user: widget.user,
        ),
        Gap(CustomPadding.paddingLarge.v),
        Padding(
          padding: EdgeInsets.only(right: CustomPadding.paddingLarge),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MiniLoadingButton(
                icon: LucideIcons.save,
                text: 'Save',
                onPressed: () {},
                useGradient: true,
                gradientColors: [Color(0xff005624), Color(0xff27AE60)],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

