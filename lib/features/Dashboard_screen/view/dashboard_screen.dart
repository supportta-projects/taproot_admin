import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/dashboard_model.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/dashboard_container.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/financial_returns_widget.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/line_graph_widget.dart';

import '../data/dashboard_services.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const path = '/dashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardModel? dashboardModel;
  Future<void> _fetchDashboardData() async {
    try {
      final response = await DashboardServices.getDashData();

      if (response.success) {
        logSuccess(response.message);
        setState(() {
          dashboardModel = response;
        });
      } else {}
    } catch (e) {
      logError('Error fetching dashboard data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  final List<ChartData> data = [
    ChartData('Jan', 500, 200, 1000),
    ChartData('Feb', 700, 250, 1200),
    ChartData('March', 600, 300, 1100),
    ChartData('April', 800, 350, 1300),
    ChartData('May', 750, 300, 1250),
    ChartData('June', 900, 400, 1400),
  ];

  @override
  Widget build(BuildContext context) {
    double tileWidgetBorderRadius = CustomPadding.padding;
    if (dashboardModel == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: CustomPadding.paddingLarge),
              child: Text('Dashboard', style: context.inter60024),
            ),
            Gap(CustomPadding.paddingLarge),
            FinancialReturnsWidget(dashboardModel: dashboardModel),
            Gap(CustomPadding.paddingLarge),
            Row(
              children: [
                Gap(CustomPadding.paddingLarge),

                Expanded(child: LineGraphWidget(data: data)),
                Gap(CustomPadding.paddingXL),

                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.red,
                //       borderRadius: BorderRadius.circular(
                //         CustomPadding.padding,
                //       ),
                //     ),
                //     child: Expanded(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         spacing: CustomPadding.padding,
                //         children: [
                //           OrderDetailsContainer(
                //             borderRadius: tileWidgetBorderRadius,
                //             title: 'Total Orders',
                //             totalCount:
                //                 dashboardModel!.result.result.totalOrder,

                //             statusTitle: 'Order',
                //           ),
                //           OrderDetailsContainer(
                //             borderRadius: tileWidgetBorderRadius,
                //             title: 'Total Orders Delivered',
                //             totalCount:
                //                 dashboardModel!.result.result.deliveredOrder,

                //             statusTitle: 'Delivered Order',
                //           ),
                //           RefundOrderContainer(
                //             borderRadius: tileWidgetBorderRadius,
                //             title: 'Refunded Orders',
                //             refundCount:
                //                 dashboardModel!.result.result.cancelledOrder,

                //             refundedAmount:
                //                 dashboardModel!.result.result.refundAmount
                //                     .toInt(),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Gap(CustomPadding.paddingLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
