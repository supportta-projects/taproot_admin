import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/view/order_details_screen.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/widgets/gradient_text.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class OrderScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? innerNavigatorKey;

  static const path = '/orderScreen';

  const OrderScreen({super.key, this.innerNavigatorKey});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<String> statusList = List.generate(10, (index) => 'Placed');
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
                    text: 'Create Order',
                    onPressed: () {},
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
                height: SizeUtils.height,

                child: Column(
                  children: [
                    Row(
                      children: [
                        SearchWidget(hintText: 'Search Order ID, Username'),
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
                        Tab(text: 'Order Placed'),
                        Tab(text: 'Shipped'),
                        Tab(text: 'Delivered'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          DataTable(
                            dataRowMaxHeight: 80,
                            columns: [
                              DataColumn(label: Text('Order ID')),
                              DataColumn(label: Text('Full Name')),
                              DataColumn(label: Text('User ID')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Order Count')),
                              DataColumn(label: Text('Status')),
                            ],
                            rows: List.generate(10, (index) {
                              void handleRowTap() {
                                final navigator =
                                    widget.innerNavigatorKey?.currentState ??
                                    Navigator.of(context);
                                navigator.push(
                                  MaterialPageRoute(
                                    builder:
                                        (_) => OrderDetailScreen(
                                          orderId: 'OrderID$index',
                                        ),
                                  ),
                                );
                              }

                              return DataRow(
                                cells: [
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(
                                        child: Text(
                                          'OrderID$index',
                                          style: context.inter60016.copyWith(
                                            color: CustomColors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(
                                        child: Text('shahil $index'),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(
                                        child: Text('UserID$index'),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(child: Text('9234567890')),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(
                                        child: Text('₹${(index + 1) * 1000}'),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: handleRowTap,
                                      child: Center(
                                        child: Text('${index + 1}'),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              CustomPadding.paddingLarge.v,
                                        ),
                                        height: 50.v,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            CustomPadding.padding.v,
                                          ),
                                          border: Border.all(
                                            color:
                                                CustomColors.textColorLightGrey,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          value: statusList[index],
                                          items:
                                              [
                                                'Placed',
                                                'Shipped',
                                                'Delivered',
                                              ].map((status) {
                                                return DropdownMenuItem<String>(
                                                  value: status,
                                                  child: GradientText(
                                                    status,
                                                    gradient:
                                                        CustomColors
                                                            .borderGradient,
                                                    style: context.inter60014,
                                                  ),
                                                );
                                              }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              statusList[index] =
                                                  newValue.toString();
                                            });
                                            logInfo(
                                              'Order $index status changed to $newValue',
                                            );
                                          },

                                          style: context.inter50014,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          Center(child: Text('data')),
                          Center(child: Text('data')),
                          Center(child: Text('data')),
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
