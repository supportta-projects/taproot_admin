import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class CommonProductContainer extends StatelessWidget {
  final bool isAmountContainer;
  final List<Widget>? children;
  final String title;
  final int? grandTotal;
  const CommonProductContainer({
    required this.title,
    super.key,
    this.children,
    this.isAmountContainer = false,
    this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingLarge.v),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeUtils.height * 0.06,
              decoration: BoxDecoration(
                color: CustomColors.lightGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(CustomPadding.paddingLarge),
                  topRight: Radius.circular(CustomPadding.paddingLarge),
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
            isAmountContainer ? Divider(indent: 40, endIndent: 40) : SizedBox(),
            isAmountContainer
                ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: CustomPadding.padding.v,
                    horizontal: CustomPadding.paddingXL.v,
                  ),
                  child: Row(
                    children: [
                      Text('Total Amount'),
                      Spacer(),
                      Text('₹$grandTotal', style: context.inter50024),
                    ],
                  ),
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
