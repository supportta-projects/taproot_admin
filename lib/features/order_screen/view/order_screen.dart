import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/view/create_order.dart';
import 'package:taproot_admin/features/order_screen/view/order_details_screen.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';

import 'package:taproot_admin/widgets/mini_loading_button.dart';

class OrderScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? innerNavigatorKey;

  static const path = '/orderScreen';

  const OrderScreen({super.key, this.innerNavigatorKey});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> allOrder = [];
  bool isLoading = true;
  int currentPage = 1;
  int totalPages = 1;
  int totalOrder = 0;
  final int _rowsPerPage = 10;
  OrderDataSource? orderDataSource;
  final _tableKey = GlobalKey<PaginatedDataTableState>();

  void retryOrder(int index) {
    logInfo('Retrying order $index');
  }

  void dispatchOrder(int index) {
    logInfo('Dispatching order $index');
  }

  void completeOrder(int index) {
    logInfo('Completing order $index');
  }

  // List<String> statusList = [
  //   'pending',
  //   'failed',
  //   'placed',
  //   'shipped',
  //   'order completed',
  //   'failed',
  //   'placed',
  //   'shipped',
  //   'pending',
  //   'order completed',
  // ];
  Future<void> fetchAllOrder() async {
    setState(() => isLoading = true);

    try {
      logInfo('Fetching page: $currentPage');
      final response = await OrderService.getAllOrder(page: currentPage);

      if (!mounted) return;

      setState(() {
        allOrder = response.results;
        totalOrder = response.totalCount;
        totalPages = (totalOrder / _rowsPerPage).ceil();
        orderDataSource?.dispose();
        orderDataSource = OrderDataSource(
          allOrder,
          totalOrder,
          context,
          widget.innerNavigatorKey,
          _rowsPerPage,
        );
        isLoading = false;
      });
    } catch (e) {
      logInfo('Error fetching orders: $e');
      setState(() => isLoading = false);
    }
  }

  void handlePageChange(int firstRowIndex) {
    final newPage = (firstRowIndex ~/ _rowsPerPage) + 1;
    logInfo('Changing to page: $newPage (from index: $firstRowIndex)');

    if (newPage != currentPage && newPage <= totalPages) {
      setState(() {
        currentPage = newPage;
      });
      fetchAllOrder();
    }
  }

  @override
  void initState() {
    fetchAllOrder();

    // TODO: implement initState
    super.initState();
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
                    SizedBox(
                      height: SizeUtils.height * 0.75,
                      child: TabBarView(
                        children: [
                          // DataTable(
                          //   dataRowMaxHeight: 80,
                          //   columns: [
                          //     DataColumn(label: Text('Order ID')),
                          //     DataColumn(label: Text('Full Name')),
                          //     DataColumn(label: Text('Phone')),
                          //     DataColumn(label: Text('Amount')),
                          //     DataColumn(label: Text('Order Count')),
                          //     DataColumn(label: Text('Status')),
                          //     DataColumn(label: Text('Action')),
                          //   ],
                          //   rows: List.generate(10, (index) {
                          //     void handleRowTap() {
                          //       final navigator =
                          //           widget.innerNavigatorKey?.currentState ??
                          //           Navigator.of(context);
                          //       navigator.push(
                          //         MaterialPageRoute(
                          //           builder:
                          //               (_) => OrderDetailScreen(
                          //                 user: User(
                          //                   id: 'm',
                          //                   fullName: 'sss',
                          //                   userId: 'ss',
                          //                   phone: 'ssss',
                          //                   whatsapp: 'ssss',
                          //                   email: 'ssss',
                          //                   website: 'sssss',
                          //                   isPremium: false,
                          //                 ),
                          //                 orderId: 'OrderID$index',
                          //               ),
                          //         ),
                          //       );
                          //     }

                          //     String status = statusList[index];
                          //     String? actionLabel;

                          //     switch (status) {
                          //       case 'failed':
                          //         actionLabel = 'Retry';
                          //         break;
                          //       case 'placed':
                          //         actionLabel = 'Dispatch';
                          //         break;
                          //       case 'shipped':
                          //         actionLabel = 'Complete Order';
                          //         break;
                          //       default:
                          //         actionLabel = null;
                          //     }

                          //     return DataRow(
                          //       cells: [
                          //         DataCell(
                          //           InkWell(
                          //             onTap: handleRowTap,
                          //             child: Center(
                          //               child: Text(
                          //                 'OrderID$index',
                          //                 style: context.inter60016.copyWith(
                          //                   color: CustomColors.green,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         DataCell(
                          //           InkWell(
                          //             onTap: handleRowTap,
                          //             child: Center(
                          //               child: Text('shahil $index'),
                          //             ),
                          //           ),
                          //         ),

                          //         DataCell(
                          //           InkWell(
                          //             onTap: handleRowTap,
                          //             child: Center(child: Text('9234567890')),
                          //           ),
                          //         ),
                          //         DataCell(
                          //           InkWell(
                          //             onTap: handleRowTap,
                          //             child: Center(
                          //               child: Text('₹${(index + 1) * 1000}'),
                          //             ),
                          //           ),
                          //         ),
                          //         DataCell(
                          //           InkWell(
                          //             onTap: handleRowTap,
                          //             child: Center(
                          //               child: Text('${index + 1}'),
                          //             ),
                          //           ),
                          //         ),

                          //         DataCell(
                          //           Center(
                          //             child: GradientText(
                          //               status,
                          //               gradient: CustomColors.borderGradient,
                          //               style: context.inter50016,
                          //             ),
                          //           ),
                          //         ),
                          //         DataCell(
                          //           actionLabel == null
                          //               ? SizedBox()
                          //               : MiniLoadingButton(
                          //                 needRow: false,

                          //                 text: actionLabel,
                          //                 onPressed: () {
                          //                   setState(() {
                          //                     switch (actionLabel) {
                          //                       case 'Retry':
                          //                         statusList[index] = 'placed';
                          //                         break;
                          //                       case 'Dispatch':
                          //                         statusList[index] = 'shipped';
                          //                         break;
                          //                       case 'Complete Order':
                          //                         statusList[index] =
                          //                             'order completed';
                          //                         break;
                          //                     }
                          //                   });
                          //                   logInfo(
                          //                     'Order $index action "$actionLabel" performed',
                          //                   );
                          //                 },
                          //                 useGradient: true,
                          //                 gradientColors:
                          //                     CustomColors
                          //                         .borderGradient
                          //                         .colors,
                          //               ),
                          //         ),
                          //       ],
                          //     );
                          //   }),
                          // ),
                          PaginatedDataTable(
                            key: _tableKey,
                            dataRowMaxHeight: 60,
                            rowsPerPage: _rowsPerPage,
                            initialFirstRowIndex:
                                (currentPage - 1) * _rowsPerPage,
                            onPageChanged: handlePageChange,
                            availableRowsPerPage: const [10, 20, 50],
                            columns: const [
                              DataColumn(label: Text('Order ID')),
                              DataColumn(label: Text('Full Name')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Order Count')),
                            ],
                            source:
                                orderDataSource ??
                                OrderDataSource(
                                  [],
                                  0,
                                  context,
                                  widget.innerNavigatorKey,
                                  _rowsPerPage,
                                ),
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

class OrderDataSource extends DataTableSource {
  final List<Order> orderList;
  final BuildContext context;
  final GlobalKey<NavigatorState>? innerNavigatorKey;
  final int totalCount;
  final int rowsPerPage;

  OrderDataSource(
    this.orderList,
    this.totalCount,
    this.context,
    this.innerNavigatorKey,
    this.rowsPerPage,
  );

  @override
  DataRow getRow(int index) {
    logInfo('Getting row at index: $index, Total orders: ${orderList.length}');

    // Calculate the index within the current page
    final pageIndex = index % rowsPerPage;

    // Check if we have data for this page index
    if (pageIndex < orderList.length) {
      final order = orderList[pageIndex]; // Use pageIndex instead of index

      void handleRowTap() {
        innerNavigatorKey?.currentState?.push(
          MaterialPageRoute(
            builder:
                (context) =>
                    OrderDetailScreen(order: order, orderId: order.code),
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
                  order.code,
                  style: context.inter60016.copyWith(color: CustomColors.green),
                ),
              ),
            ),
          ),
          DataCell(
            InkWell(
              onTap: handleRowTap,
              child: Center(child: Text(order.user.name)),
            ),
          ),
          DataCell(
            InkWell(
              onTap: handleRowTap,
              child: Center(child: Text(order.address.mobile)),
            ),
          ),
          DataCell(
            InkWell(
              onTap: handleRowTap,
              child: Center(child: Text('₹${order.totalAmount}')),
            ),
          ),
          DataCell(
            InkWell(
              onTap: handleRowTap,
              child: Center(child: Text(order.totalProducts.toString())),
            ),
          ),
        ],
      );
    }

    // Return empty row if no data available
    return DataRow(
      cells: List<DataCell>.generate(5, (index) => const DataCell(Text('-'))),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount; // This should be the total count across all pages

  @override
  int get selectedRowCount => 0;
}

// class OrderDataSource extends DataTableSource {
//   final List<Order> orderList;
//   // final List<String> statusList;
//   final BuildContext context;
//   final GlobalKey<NavigatorState>? innerNavigatorKey;
//   final int totalCount;
//   final int rowsPerPage;
//   OrderDataSource(
//     this.orderList,
//     this.totalCount,
//     this.context,
//     this.innerNavigatorKey,
//     this.rowsPerPage,
//   );

//   @override
//   DataRow getRow(int index) {
//     print('Getting row at index: $index, Total orders: ${orderList.length}');

//     // Calculate the actual index within the current page
//     final pageIndex = index % rowsPerPage;

//     if (pageIndex >= orderList.length) {
//       return DataRow(
//         cells: List<DataCell>.generate(5, (index) => const DataCell(Text('-'))),
//       );
//     }
//     final order = orderList[index];
//     void handleRowTap() {
//       innerNavigatorKey?.currentState?.push(
//         MaterialPageRoute(
//           builder:
//               (context) => OrderDetailScreen(order: order, orderId: order.code),
//         ),
//       );
//     }
//     // final navigator = navigatorKey?.currentState ?? Navigator.of(context);
//     // navigator.push(
//     //   MaterialPageRoute(
//     //     builder:
//     //         (_) => OrderDetailScreen(
//     //           order: order,
//     //           // user: User(
//     //           //   id: 'm',
//     //           //   fullName: 'sss',
//     //           //   userId: 'ss',
//     //           //   phone: 'ssss',
//     //           //   whatsapp: 'ssss',
//     //           //   email: 'ssss',
//     //           //   website: 'sssss',
//     //           //   isPremium: false,
//     //           // ),
//     //           orderId: order.code,
//     //         ),
//     //   ),
//     //   // );
//     // }

//     // String status = statusList[index];
//     // String? actionLabel;
//     // switch (status) {
//     //   case 'failed':
//     //     actionLabel = 'Retry';
//     //     break;
//     //   case 'placed':
//     //     actionLabel = 'Dispatch';
//     //     break;
//     //   case 'shipped':
//     //     actionLabel = 'Complete Order';
//     //     break;
//     // }

//     return DataRow(
//       cells: [
//         DataCell(
//           InkWell(
//             onTap: handleRowTap,
//             child: Center(
//               child: Text(
//                 order.code,
//                 style: context.inter60016.copyWith(color: CustomColors.green),
//               ),
//             ),
//           ),
//         ),
//         DataCell(
//           InkWell(
//             onTap: handleRowTap,
//             child: Center(child: Text(order.user.name)),
//           ),
//         ),
//         DataCell(
//           InkWell(
//             onTap: handleRowTap,
//             child: Center(child: Text(order.address.mobile)),
//           ),
//         ),
//         DataCell(
//           InkWell(
//             onTap: handleRowTap,
//             child: Center(child: Text('₹${order.totalAmount}')),
//           ),
//         ),
//         DataCell(
//           InkWell(
//             onTap: handleRowTap,
//             child: Center(child: Text(order.totalProducts.toString())),
//           ),
//         ),
//         // DataCell(
//         //   Center(
//         //     child: GradientText(
//         //       status,
//         //       gradient: CustomColors.borderGradient,
//         //       style: context.inter50016,
//         //     ),
//         //   ),
//         // ),
//         // DataCell(
//         //   actionLabel == null
//         //       ? const SizedBox()
//         //       : MiniLoadingButton(
//         //         needRow: false,
//         //         text: actionLabel,
//         //         onPressed: () {
//         //           switch (actionLabel) {
//         //             case 'Retry':
//         //               statusList[index] = 'placed';
//         //               break;
//         //             case 'Dispatch':
//         //               statusList[index] = 'shipped';
//         //               break;
//         //             case 'Complete Order':
//         //               statusList[index] = 'order completed';
//         //               break;
//         //           }
//         //           logInfo('Order $index action "$actionLabel" performed');
//         //           notifyParent(); // refresh widget
//         //         },
//         //         useGradient: true,
//         //         gradientColors: CustomColors.borderGradient.colors,
//         //       ),
//         // ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => totalCount;

//   @override
//   int get selectedRowCount => 0;
// }
