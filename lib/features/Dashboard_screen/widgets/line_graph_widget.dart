import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';

import '../../../exporter/exporter.dart';

class LineGraphWidget extends StatelessWidget {
  const LineGraphWidget({super.key, required this.data});

  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CustomPadding.paddingXL),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(
          CustomPadding.paddingXL + CustomPadding.padding,
        ),
      ),
      height: 600,
      child: SfCartesianChart(
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: CategoryAxis(labelPlacement: LabelPlacement.onTicks),
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
    );
  }
}
