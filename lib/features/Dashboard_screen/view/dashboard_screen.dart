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
  ChartData? chartData;
  bool isLoading = true;
  String? error;
  Future<void> _fetchDashboardData() async {
    try {
      final response = await DashboardServices.getDashData();
      final chartResponse = await DashboardServices.getChartData();

      if (response.success && chartResponse.success!) {
        logSuccess(response.message);
        setState(() {
          chartData = chartResponse;
          dashboardModel = response;
          isLoading = false;
        });
      } else {}
    } catch (e) {
      logError('Error fetching dashboard data: $e');
    }
  }

  Future<void> _refreshData() async {
    await _fetchDashboardData();
  }

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    double normalPadding = CustomPadding.padding * 2.2;
    double tileWidgetBorderRadius = CustomPadding.padding * 2.5;
    if (dashboardModel == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Scaffold(
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
      ),
    );
  }
}
