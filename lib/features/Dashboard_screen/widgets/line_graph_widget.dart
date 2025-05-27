import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';

import '../../../exporter/exporter.dart';

class LineGraphWidget extends StatelessWidget {
  const LineGraphWidget({super.key, required this.data});

  final List<MonthlyData> data;
  String _formatNumber(num number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

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
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
        ),
        primaryXAxis: CategoryAxis(labelPlacement: LabelPlacement.onTicks),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0.5),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel(
              _formatNumber(details.value),
              details.textStyle,
            );
          },
        ),

        series: <CartesianSeries>[
          LineSeries<MonthlyData, String>(
            color: CustomColors.red,
            name: 'Expense',
            dataSource: data,
            xValueMapper: (MonthlyData d, _) => d.month,
            yValueMapper: (MonthlyData d, _) => d.expense,
            markerSettings: MarkerSettings(isVisible: true),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (
                dynamic data,
                dynamic point,
                dynamic series,
                int pointIndex,
                int seriesIndex,
              ) {
                return Text(_formatNumber(data.expense ?? 0));
              },
            ),
          ),
          LineSeries<MonthlyData, String>(
            color: CustomColors.green,
            name: 'Profit',
            dataSource: data,
            xValueMapper: (MonthlyData d, _) => d.month,
            yValueMapper: (MonthlyData d, _) => d.profit,
            markerSettings: MarkerSettings(isVisible: true),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (
                dynamic data,
                dynamic point,
                dynamic series,
                int pointIndex,
                int seriesIndex,
              ) {
                return Text(_formatNumber(data.profit ?? 0));
              },
            ),
          ),
          LineSeries<MonthlyData, String>(
            color: CustomColors.buttonColor1,
            name: 'Revenue',
            dataSource: data,
            xValueMapper: (MonthlyData d, _) => d.month,
            yValueMapper: (MonthlyData d, _) => d.revenue,
            markerSettings: MarkerSettings(isVisible: true),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (
                dynamic data,
                dynamic point,
                dynamic series,
                int pointIndex,
                int seriesIndex,
              ) {
                return Text(_formatNumber(data.revenue ?? 0));
              },
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:taproot_admin/features/Dashboard_screen/data/chart_data.dart';
// import '../../../exporter/exporter.dart';

// class LineGraphWidget extends StatelessWidget {
//   const LineGraphWidget({super.key, required this.data});

//   final List<MonthlyData> data;

//   @override
//   Widget build(BuildContext context) {
//     if (data.isEmpty) {
//       return Container(
//         padding: EdgeInsets.all(CustomPadding.paddingXL),
//         decoration: BoxDecoration(
//           color: CustomColors.secondaryColor,
//           borderRadius: BorderRadius.circular(
//             CustomPadding.paddingXL + CustomPadding.padding,
//           ),
//         ),
//         height: 400,
//         child: const Center(child: Text('No data available')),
//       );
//     }

//     return Container(
//       padding: EdgeInsets.all(CustomPadding.paddingXL),
//       decoration: BoxDecoration(
//         color: CustomColors.secondaryColor,
//         borderRadius: BorderRadius.circular(
//           CustomPadding.paddingXL + CustomPadding.padding,
//         ),
//       ),
//       height: 400,
//       child: SfCartesianChart(
//         legend: const Legend(
//           isVisible: true,
//           position: LegendPosition.bottom,
//           alignment: ChartAlignment.center,
//         ),
//         tooltipBehavior: TooltipBehavior(
//           enable: true,
//           format: 'point.x : \$point.y',
//         ),
//         zoomPanBehavior: ZoomPanBehavior(
//           enablePinching: true,
//           enableDoubleTapZooming: true,
//           enablePanning: true,
//         ),
//         primaryXAxis: CategoryAxis(
//           labelPlacement: LabelPlacement.onTicks,
//           labelRotation: -45,
//           majorGridLines: const MajorGridLines(width: 0),
//         ),
//         primaryYAxis: NumericAxis(
//           numberFormat: NumberFormat.compact(),
//           majorGridLines: const MajorGridLines(width: 0.5),
//         ),
//         crosshairBehavior: CrosshairBehavior(
//           enable: true,
//           activationMode: ActivationMode.singleTap,
//         ),
//         series: <CartesianSeries>[
//           LineSeries<MonthlyData, String>(
//             color: CustomColors.red,
//             name: 'Expense',
//             dataSource: data,
//             xValueMapper: (MonthlyData data, _) => data.month ?? '',
//             yValueMapper: (MonthlyData data, _) => data.expense ?? 0,
//             markerSettings: const MarkerSettings(isVisible: true),
//           ),
//           LineSeries<MonthlyData, String>(
//             color: CustomColors.green,
//             name: 'Profit',
//             dataSource: data,
//             xValueMapper: (MonthlyData data, _) => data.month ?? '',
//             yValueMapper: (MonthlyData data, _) => data.profit ?? 0,
//             markerSettings: const MarkerSettings(isVisible: true),
//           ),
//           LineSeries<MonthlyData, String>(
//             color: CustomColors.buttonColor1,
//             name: 'Revenue',
//             dataSource: data,
//             xValueMapper: (MonthlyData data, _) => data.month ?? '',
//             yValueMapper: (MonthlyData data, _) => data.revenue ?? 0,
//             markerSettings: const MarkerSettings(isVisible: true),
//           ),
//         ],
//       ),
//     );
//   }
// }
