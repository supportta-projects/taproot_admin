import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class RefundOrderContainer extends StatelessWidget {
  final String title;
  final int refundCount;
  final int refundedAmount;
  const RefundOrderContainer({
    super.key,
    required this.title,
    required this.refundCount,
    required this.refundedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: CustomPadding.paddingXL.v),

      padding: EdgeInsets.all(CustomPadding.paddingXL.v),
      width: double.infinity,
      height: 170.v,
      decoration: BoxDecoration(
        color: CustomColors.greylight,
        borderRadius: BorderRadius.circular(CustomPadding.padding.v),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: context.inter50014),
              Spacer(),
              Icon(LucideIcons.banknoteArrowDown, color: CustomColors.red),
            ],
          ),
          Gap(CustomPadding.paddingXL.v),
          Row(
            children: [
              Text(refundCount.toString(), style: context.inter60024),
              Spacer(),
              Text('Refunded Amount'),
              Icon(Icons.arrow_downward, color: CustomColors.red),
              Text(
                '₹$refundedAmount',
                style: TextStyle(color: CustomColors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
