import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class ServiceImage extends StatelessWidget {
  const ServiceImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.textColorLightGrey,

        borderRadius: BorderRadius.circular(CustomPadding.padding.v),
      ),
      width: 150,
      height: 150,
      child: Center(
        child: Icon(
          LucideIcons.image,
          color: CustomColors.textColorDarkGrey,
          size: SizeUtils.height * 0.1,
        ),
      ),
    );
  }
}
