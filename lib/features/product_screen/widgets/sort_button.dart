import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.v,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomPadding.paddingXXL.v),
        border: Border.all(color: CustomColors.textColorLightGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sort', style: context.inter50014),
          Gap(CustomPadding.padding.v),
          Icon(
            LucideIcons.arrowDownNarrowWide,
            color: CustomColors.textColorGrey,
          ),
        ],
      ),
    );
  }
}
