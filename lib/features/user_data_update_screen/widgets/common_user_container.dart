import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class CommonUserContainer extends StatelessWidget {
  final List<Widget>? children;
  final String title;
  const CommonUserContainer({required this.title, super.key, this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(CustomPadding.padding),
        ),

        height: SizeUtils.height * 0.40,
        child: Column(
          children: [
            Container(
              height: SizeUtils.height * 0.06,
              decoration: BoxDecoration(
                color: CustomColors.lightGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(CustomPadding.padding),
                  topRight: Radius.circular(CustomPadding.padding),
                ),
              ),

              child: Row(
                children: [
                  Gap(CustomPadding.paddingLarge),

                  Text(title, style: context.inter60022),
                ],
              ),
            ),
            Column(children: children ?? []),
          ],
        ),
      ),
    );
  }
}
