import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class OrderDetailsContainer extends StatelessWidget {
  final String title;
  final String statusTitle;
  final int totalCount;
  final int statusCount;
  const OrderDetailsContainer({
    super.key,
    required this.totalCount,
    required this.statusCount,
    required this.statusTitle,
    required this.title,
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
              Icon(LucideIcons.package, color: CustomColors.brown),
            ],
          ),
          Gap(CustomPadding.paddingXL.v),

          Row(
            children: [
              Text(totalCount.toString(), style: context.inter60024),
              Gap(CustomPadding.paddingXL.v),
              Text(
                statusCount.toString(),
                style: TextStyle(color: CustomColors.green),
              ),
              Gap(CustomPadding.padding.v),

              Text(statusTitle),
            ],
          ),
        ],
      ),
    );
  }
}
