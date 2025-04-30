import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class LinkContainer extends StatelessWidget {
  final String name;
  final String svg;

  const LinkContainer({
    super.key,
    required this.user,
    required this.name,
    required this.svg,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70.v,
            color: Colors.white,
            child: Row(
              children: [
                Gap(CustomPadding.paddingXL.v),

                SvgPicture.asset(svg),
                Gap(CustomPadding.paddingLarge.v),
                Text(
                  name,
                  style: context.inter60016.copyWith(
                    fontSize: 16.fSize,
                    color: CustomColors.textColorGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 70,
            color: Colors.white,
            child: TextFormContainer(
              initialValue: '',
              labelText: 'Link',
              user: user,
            ),
          ),
        ),
      ],
    );
  }
}
