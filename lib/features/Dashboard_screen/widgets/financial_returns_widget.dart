import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/dashboard_container.dart';

import '../../../exporter/exporter.dart';
import '../data/dashboard_model.dart';


class FinancialReturnsWidget extends StatelessWidget {
  const FinancialReturnsWidget({super.key, required this.dashboardModel});

  final DashboardModel? dashboardModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: CustomPadding.paddingLarge),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(
          CustomPadding.padding + CustomPadding.paddingLarge,
        ),
      ),
      child: Row(
        children: [
          DashBoardContainer(
            title: 'Revenue',
            amount: dashboardModel!.result.result.revenue.toString(),
            percentage: '8',
            icon: LucideIcons.banknote,
            iconColor: CustomColors.buttonColor1,
          ),
          DashBoardContainer(
            isExpense: true,
            title: 'Expense',
            amount: dashboardModel!.result.result.expense.toString(),
            icon: LucideIcons.banknoteArrowDown,
            iconColor: CustomColors.red,
            percentage: '8',
          ),
          DashBoardContainer(
            title: 'Profit',
            amount: dashboardModel!.result.result.profit.toString(),
            percentage: '8',
            icon: LucideIcons.banknoteArrowUp,
            iconColor: CustomColors.green,
          ),
        ],
      ),
    );
  }
}
