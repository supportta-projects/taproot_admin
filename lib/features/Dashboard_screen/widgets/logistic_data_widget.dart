import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/dashboard_model.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/logistic_tile_widget.dart';

import '../../../exporter/exporter.dart';

class LogisticDataWidget extends StatelessWidget {
  const LogisticDataWidget({
    super.key,
    required this.normalPadding,
    required this.tileWidgetBorderRadius,
    required this.data,
  });
  final DashboardModel data;
  final double normalPadding;
  final double tileWidgetBorderRadius;

  @override
  Widget build(BuildContext context) {
    int totalOrders = data.result.result.totalOrder;
    int cancelledOrders = data.result.result.cancelledOrder;
    int completedOrders = data.result.result.deliveredOrder;

    return Container(
      width: (620 / 1440) * MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(CustomPadding.paddingXL),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(
          normalPadding + tileWidgetBorderRadius,
          // CustomPadding.paddingXL + CustomPadding.padding,
        ),
      ),

      child: Expanded(
        child: Column(
          children: [
            LogisticTileWidget(
              numericaldata: totalOrders,
              tileWidgetBorderRadius: tileWidgetBorderRadius,
              normalPadding: normalPadding,

              supportingWidget: Text('orders'),
            ),

            Gap(CustomPadding.paddingXL),

            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: Icon(LucideIcons.mapPin),
            //   title: Text('Taproot Admin Office'),
            //   subtitle: Text('123 Main St, City, Country'),
            //   trailing: Icon(LucideIcons.chevronRight),
            // ),
          ],
        ),
      ),
    );
  }
}
