import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/gen/assets.gen.dart';

class UserProfileContainer extends StatelessWidget {
  const UserProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.hoverColor,
          // color: CustomColors.lightGreen,
          borderRadius: BorderRadius.circular(CustomPadding.padding),
        ),

        height: SizeUtils.height * 0.40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.v,
              height: 200.v,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: CustomColors.textColorLightGrey,
              ),
              child: Center(
                child: Icon(
                  LucideIcons.userRound,
                  color: CustomColors.textColorDarkGrey,
                  size: SizeUtils.height * 0.1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CustomPadding.padding,
              ),
              child: Text(
                'User ID',
                style: context.inter60020.copyWith(fontSize: 20.fSize),
              ),
            ),

            // SizedBox(
            //   width: 180.v,
            //   child: GradientBorderButton(
            //     borderGradientColor: CustomColors.borderGradient,
            //     children: [
            //       ShaderMask(
            //         blendMode: BlendMode.srcIn,
            //         shaderCallback:
            //             (Rect bounds) => RadialGradient(
            //               center: Alignment.topCenter,
            //               stops: [.5, 1],

            //               colors: [
            //                 CustomColors.hoverColor,
            //                 CustomColors.primaryColor,
            //               ],
            //               // colors: [CustomColors.green, CustomColors.greenDark],
            //             ).createShader(bounds),
            //         child: Icon(LucideIcons.box),
            //       ),
            //       Text(
            //         'Total Orders',
            //         style: context.inter50014.copyWith(fontSize: 14.fSize),
            //       ),

            //       Text(
            //         '2',
            //         style: context.inter50018.copyWith(fontSize: 18.fSize),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              width: 150.v,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
                color: CustomColors.lightGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Premium'),
                  Gap(CustomPadding.padding.v),
                  SvgPicture.asset(Assets.svg.premium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
