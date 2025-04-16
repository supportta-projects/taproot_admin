import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/gen/assets.gen.dart';

class SocialMediaContainer extends StatelessWidget {
  final String svg;
  final String name;
  const SocialMediaContainer({
    super.key,
    required this.svg,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svg),
        Gap(CustomPadding.padding.v),
        Text(
          name,
          style: context.inter60016.copyWith(
            fontSize: 16.fSize,
            color: CustomColors.textColorDarkGrey,
          ),
        ),
        Gap(CustomPadding.padding.v),
        SvgPicture.asset(Assets.svg.link),
      ],
    );
  }
}
