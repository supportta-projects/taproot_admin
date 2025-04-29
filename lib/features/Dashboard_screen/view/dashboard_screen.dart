import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/dashboard_container.dart';

class DashboardScreen extends StatelessWidget {
  final List<ChartData> data = [
    ChartData('Jan', 500, 200, 1000),
    ChartData('Feb', 700, 250, 1200),
    ChartData('March', 600, 300, 1100),
    ChartData('April', 800, 350, 1300),
    ChartData('May', 750, 300, 1250),
    ChartData('June', 900, 400, 1400),
  ];

  DashboardScreen({super.key});
  static const path = '/dashboardScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Dashboard', style: context.inter60024),
            Gap(CustomPadding.paddingLarge.v),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(
                  CustomPadding.paddingLarge.v,
                ),
              ),
              child: Row(
                children: [
                  DashBoardContainer(
                    title: 'Revenue',
                    amount: '54000',
                    percentage: '8',
                    icon: LucideIcons.banknote,
                    iconColor: CustomColors.buttonColor1,
                  ),
                  DashBoardContainer(
                    isExpense: true,
                    title: 'Expense',
                    amount: '16000',
                    icon: LucideIcons.banknoteArrowDown,
                    iconColor: CustomColors.red,
                    percentage: '8',
                  ),
                  DashBoardContainer(
                    title: 'Profit',
                    amount: '48000',
                    percentage: '8',
                    icon: LucideIcons.banknoteArrowUp,
                    iconColor: CustomColors.green,
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingLarge.v),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 500,
                    child: SfCartesianChart(
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                      ),
                      primaryYAxis: NumericAxis(),
                      series: <CartesianSeries>[
                        LineSeries<ChartData, String>(
                          color: CustomColors.red,
                          name: 'Expense',
                          dataSource: data,
                          xValueMapper: (ChartData d, _) => d.month,
                          yValueMapper: (ChartData d, _) => d.expense,
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                        LineSeries<ChartData, String>(
                          color: CustomColors.green,
                          name: 'Profit',
                          dataSource: data,
                          xValueMapper: (ChartData d, _) => d.month,
                          yValueMapper: (ChartData d, _) => d.profit,
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                        LineSeries<ChartData, String>(
                          color: CustomColors.buttonColor1,
                          name: 'Revenue',
                          dataSource: data,
                          xValueMapper: (ChartData d, _) => d.month,
                          yValueMapper: (ChartData d, _) => d.revenue,
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
