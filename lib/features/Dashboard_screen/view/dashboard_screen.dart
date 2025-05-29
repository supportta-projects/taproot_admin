import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/dashboard_model.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/financial_returns_widget.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/line_graph_widget.dart';

import '../data/dashboard_services.dart';
import '../widgets/logistic_data_widget.dart';

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
    double normalPadding = CustomPadding.padding * 2.2;
    double tileWidgetBorderRadius = CustomPadding.padding * 2.5;
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

                  child: Column(children: [LineGraphWidget(data: data)]),
                ),
                Spacer(),
                LogisticDataWidget(
                  data: dashboardModel!,
                  normalPadding: normalPadding,
                  tileWidgetBorderRadius: tileWidgetBorderRadius,
                ),

                Gap(CustomPadding.paddingLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
