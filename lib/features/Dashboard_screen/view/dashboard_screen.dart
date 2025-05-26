import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    double normalPadding = CustomPadding.padding;
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
                Gap(normalPadding),

                SizedBox(
                  width: (620 / 1440) * MediaQuery.of(context).size.width,

                  child: Expanded(
                    child: Column(children: [LineGraphWidget(data: data)]),
                  ),
                ),
                Spacer(),
                Container(
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
                        Card(
                          color: Colors.amber,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              tileWidgetBorderRadius,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(normalPadding),
                            child: Row(
                              children: [
                                // Left side: Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize:
                                        MainAxisSize
                                            .min, // Important to prevent overflow
                                    children: const [
                                      Text(
                                        'Total Orders',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '60',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Orders',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Right side: Icon
                                const Icon(
                                  Icons.inventory_2_rounded,
                                  color: Colors.brown,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
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
                ),

                // Gap(CustomPadding.paddingXL),

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
