import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';


class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  const ServiceCard({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CustomPadding.paddingLarge.v),
      height: 300.v,
      width: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomPadding.padding),
        border: Border.all(color: CustomColors.textColorLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.inter50016),
          Gap(CustomPadding.padding.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 115.v,
                  color: CustomColors.textColorLightGrey,
                  child: Center(
                    child: Icon(
                      LucideIcons.image,
                      color: CustomColors.textColorDarkGrey,
                      size: SizeUtils.height * 0.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Description',
            style: context.inter50014.copyWith(
              color: CustomColors.textFieldBorderGrey,
            ),
          ),
          Text(description, maxLines: 4, style: TextStyle()),
        ],
      ),
    );
  }
}
