import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/view/create_order.dart';
import 'package:taproot_admin/features/order_screen/view/order_details_screen.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';
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
  void retryOrder(int index) {
    logInfo('Retrying order $index');
  }

  void dispatchOrder(int index) {
    logInfo('Dispatching order $index');
  }

  void completeOrder(int index) {
    logInfo('Completing order $index');
  }

  List<String> statusList = [
    'pending',
    'failed',
    'placed',
    'shipped',
    'order completed',
    'failed',
    'placed',
    'shipped',
    'pending',
    'order completed',
  ];
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CreateOrder()),
                      );
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
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Order Count')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Action')),
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
                                          user: User(
                                            fullName: 'sss',
                                            userId: 'ss',
                                            phone: 'ssss',
                                            whatsapp: 'ssss',
                                            email: 'ssss',
                                            website: 'sssss',
                                            isPremium: false,
                                          ),
                                          orderId: 'OrderID$index',
                                        ),
                                  ),
                                );
                              }

                              String status = statusList[index];
                              String? actionLabel;

                              switch (status) {
                                case 'failed':
                                  actionLabel = 'Retry';
                                  break;
                                case 'placed':
                                  actionLabel = 'Dispatch';
                                  break;
                                case 'shipped':
                                  actionLabel = 'Complete Order';
                                  break;
                                default:
                                  actionLabel = null;
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
                                      child: GradientText(
                                        status,
                                        gradient: CustomColors.borderGradient,
                                        style: context.inter50016,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    actionLabel == null
                                        ? SizedBox()
                                        : MiniLoadingButton(
                                          needRow: false,

                                          text: actionLabel,
                                          onPressed: () {
                                            setState(() {
                                              switch (actionLabel) {
                                                case 'Retry':
                                                  statusList[index] = 'placed';
                                                  break;
                                                case 'Dispatch':
                                                  statusList[index] = 'shipped';
                                                  break;
                                                case 'Complete Order':
                                                  statusList[index] =
                                                      'order completed';
                                                  break;
                                              }
                                            });
                                            logInfo(
                                              'Order $index action "$actionLabel" performed',
                                            );
                                          },
                                          useGradient: true,
                                          gradientColors:
                                              CustomColors
                                                  .borderGradient
                                                  .colors,
                                        ),
                                    //  ElevatedButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       switch (actionLabel) {
                                    //         case 'Retry':
                                    //           statusList[index] = 'placed';
                                    //           break;
                                    //         case 'Dispatch':
                                    //           statusList[index] = 'shipped';
                                    //           break;
                                    //         case 'Complete Order':
                                    //           statusList[index] =
                                    //               'order completed';
                                    //           break;
                                    //       }
                                    //     });
                                    //     logInfo(
                                    //       'Order $index action "$actionLabel" performed',
                                    //     );
                                    //   },
                                    //   child: Text(actionLabel),
                                    // ),
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
