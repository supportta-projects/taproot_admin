import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
        ),
      ),

      child: Expanded(
        child: Column(
          spacing: normalPadding,
          children: [
            LogisticTileWidget(
              trailingIcon: Icon(LucideIcons.box),
              numericaldata: totalOrders,
              tileWidgetBorderRadius: tileWidgetBorderRadius,
              normalPadding: normalPadding,

              supportingWidget: Text('orders'),
              title: 'Total Orders',
            ),
          ],
        ),
      ),
    );
  }
}
