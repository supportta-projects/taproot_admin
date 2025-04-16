import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/services/size_utils.dart';

class ImageContainer extends StatelessWidget {
  final String title;

  const ImageContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.h,
      height: 200.v,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Gap(CustomPadding.padding.v),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.textColorLightGrey,
                borderRadius: BorderRadius.circular(CustomPadding.padding.v),
              ),
              width: 140.h,
              height: 150.v,
              child: Center(
                child: Icon(
                  LucideIcons.userRound,
                  color: CustomColors.textColorDarkGrey,
                  size: SizeUtils.height * 0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
