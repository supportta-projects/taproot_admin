import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/Expense_screen/widgets/add_expense.dart';
import 'package:taproot_admin/features/Expense_screen/widgets/expense_description_container.dart';
import 'package:taproot_admin/features/Expense_screen/widgets/filter_button.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/product_screen/widgets/sort_button.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({super.key});
  static const path = '/expenseScreen';

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  List<Map<String, String>> expenses = [];
   void addExpense(Map<String, String> expense) {
    setState(() {
      expenses.add(expense);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(CustomPadding.paddingLarge.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MiniLoadingButton(
                    icon: Icons.add,
                    text: 'Add Expense',
                    onPressed: () async{
                       final newExpense = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddExpense(),
                        ),
                      );
                      if (newExpense != null) {
                        addExpense(newExpense); // Add the new expense to the list
                      }
                    },
                    useGradient: true,
                    gradientColors: CustomColors.borderGradient.colors,
                  ),
                  Gap(CustomPadding.paddingXL.v),
                ],
              ),
              Gap(CustomPadding.paddingLarge.v),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomPadding.paddingLarge.v,
                  vertical: CustomPadding.paddingLarge.v,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: CustomPadding.paddingLarge.v,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.secondaryColor,
                  borderRadius: BorderRadius.circular(
                    CustomPadding.paddingLarge.v,
                  ),
                ),
                width: double.infinity,
                height: SizeUtils.height / 1.3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SearchWidget(hintText: 'Search Order ID, Username'),
                        Spacer(),
                        SortButton(),
                        Gap(CustomPadding.padding.v),

                        FilterButton(),
                      ],
                    ),

                    TabBar(
                      unselectedLabelColor: CustomColors.hintGrey,

                      unselectedLabelStyle: context.inter50016,
                      labelColor: CustomColors.textColor,
                      labelStyle: context.inter50016,
                      isScrollable: true,
                      indicatorColor: CustomColors.greenDark,
                      indicatorWeight: 4,
                      dragStartBehavior: DragStartBehavior.start,
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Order'),
                        Tab(text: 'Shop'),
                        Tab(text: 'Other'),
                      ],
                    ),
                    Gap(CustomPadding.paddingXL.v),
                    Expanded(
                      child: TabBarView(
                        children: [
                          DataTable(
                            dataRowMaxHeight: 110,
                            columns: [
                              DataColumn(label: Text('Expense Category')),
                              DataColumn(label: Text('Expense name')),
                              DataColumn(label: Text('Description')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Date')),
                            ],
                            rows:
                                expenses.map((expense) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            expense['category'] ?? '',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(expense['name'] ?? ''),
                                        ),
                                      ),
                                      DataCell(
                                        ExpenseDescriptionContainer(
                                          children: [
                                            Text(expense['description'] ?? ''),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            expense['amount'] ?? '₹0',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(expense['date'] ?? ''),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                          Center(child: Text('Order')),
                          Center(child: Text('Shop')),
                          Center(child: Text('other')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
