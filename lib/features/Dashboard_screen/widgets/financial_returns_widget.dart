import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/features/Dashboard_screen/widgets/dashboard_container.dart';

import '../../../exporter/exporter.dart';
import '../data/dashboard_model.dart';

class FinancialReturnsWidget extends StatelessWidget {
  const FinancialReturnsWidget({super.key, required this.dashboardModel});

  final DashboardModel? dashboardModel;

  String formatAmount(num amount) {
    final formatter = NumberFormat('#,###.##');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    double expenseValue = dashboardModel!.result.result.expense;
    double revenueValue = dashboardModel!.result.result.revenue;
    double profitValue = dashboardModel!.result.result.profit;

    String revenueChange =
        dashboardModel!.result.result.revenueChange.toString();
    String expenseChange =
        dashboardModel!.result.result.expenseChange.toString();
    String profitChange = dashboardModel!.result.result.profitChange.toString();

    // Get the numeric values for comparison
    double revenueChangeNum = dashboardModel!.result.result.revenueChange;
    double expenseChangeNum = dashboardModel!.result.result.expenseChange;
    double profitChangeNum = dashboardModel!.result.result.profitChange;
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
            amount: formatAmount(revenueValue),
            percentage: dashboardModel!.result.result.revenueChange.toString(),

            icon: LucideIcons.banknote,
            iconColor: CustomColors.buttonColor1,
            isExpense: double.parse(revenueChange) < 0,
          ),
          DashBoardContainer(
            // isExpense: true,
            title: 'Expense',
            amount: formatAmount(expenseValue),
            icon: LucideIcons.banknoteArrowDown,
            iconColor: CustomColors.red,
            percentage: dashboardModel!.result.result.expenseChange.toString(),
            isExpense: double.parse(expenseChange) < 0,
          ),
          DashBoardContainer(
            title: 'Profit',
            amount: formatAmount(profitValue),
            percentage: dashboardModel!.result.result.profitChange.toString(),
            icon: LucideIcons.banknoteArrowUp,
            iconColor: CustomColors.green,
            isExpense: double.parse(profitChange) < 0,
          ),
        ],
      ),
    );
  }
}
