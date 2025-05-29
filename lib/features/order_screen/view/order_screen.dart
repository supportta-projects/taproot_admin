import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/view/create_order.dart';
import 'package:taproot_admin/features/order_screen/view/order_details_screen.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/product_screen/widgets/sort_button.dart';

import 'package:taproot_admin/widgets/mini_loading_button.dart';
import 'package:taproot_admin/widgets/not_found_widget.dart';

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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounceTimer;
  int _currentTabIndex = 0;
  String getOrderStatusForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return '';
      case 1:
        return 'Placed';
      case 2:
        return 'Shipped';
      case 3:
        return 'Completed';
      case 4:
        return 'Pending';
      case 5:
        return 'Confirmed';
      case 6:
        return 'Failed';
      default:
        return '';
    }
  }

  void retryOrder(int index) {
    logInfo('Retrying order $index');
  }

  void dispatchOrder(int index) {
    logInfo('Dispatching order $index');
  }

  void completeOrder(int index) {
    logInfo('Completing order $index');
  }

  Future<void> fetchDateFilteredOrder(String pickedDate) async {
    setState(() => isLoading = true);

    try {
      logInfo('Fetching page: $currentPage');
      final response = await OrderService.getAllOrder(
        page: currentPage,
        search: _searchQuery,
        orderStatus: getOrderStatusForTab(_currentTabIndex),
        startDate: pickedDate,
      );

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

  Future<void> fetchAllOrder() async {
    setState(() => isLoading = true);

    try {
      logInfo('Fetching page: $currentPage');
      final response = await OrderService.getAllOrder(
        page: currentPage,
        search: _searchQuery,
        orderStatus: getOrderStatusForTab(_currentTabIndex),
      );

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

  void handleSearch(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = value;
        currentPage = 1;
      });

      _tableKey.currentState?.pageTo(0);

      fetchAllOrder();
    });
  }

  void handleTabChange(int index) {
    setState(() {
      _currentTabIndex = index;
      currentPage = 1;
    });
    fetchAllOrder();
  }

  @override
  void initState() {
    fetchAllOrder();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
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
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CreateOrder(refreshOrders: fetchAllOrder),
                        ),
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
                        SearchWidget(
                          hintText: 'Search Order ID, Username',
                          controller: _searchController,
                          onChanged: handleSearch,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              
                              context: context,
                              firstDate: DateTime.utc(2024),
                              lastDate: DateTime.now(),
                            ).then((selectedDate) {
                              fetchDateFilteredOrder(selectedDate.toString());

                              if (selectedDate != null) {
                                // Handle the selected date here
                                logInfo('Selected date: $selectedDate');
                              }
                            });
                          },
                          child: Container(
                            width: 110.v,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                CustomPadding.paddingXXL.v,
                              ),
                              border: Border.all(
                                color: CustomColors.textColorLightGrey,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Filter', style: context.inter50014),
                                Gap(CustomPadding.padding.v),
                                Icon(
                                  LucideIcons.funnel,
                                  color: CustomColors.textColorGrey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                      onTap: handleTabChange,
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
                        Tab(text: 'Completed'),
                        Tab(text: 'Pending'),
                        Tab(text: 'Confirmed'),
                        Tab(text: 'Failed'),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtils.height * 0.75,
                      child: TabBarView(
                        children: List.generate(7, (index) {
                          if (isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (allOrder.isEmpty) {
                            return NotFoundWidget();
                          }

                          return PaginatedDataTable(
                            key: index == 0 ? _tableKey : null,
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
                          );
                        }),
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

    final pageIndex = index % rowsPerPage;

    if (pageIndex < orderList.length) {
      final order = orderList[pageIndex];

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

    return DataRow(
      cells: List<DataCell>.generate(5, (index) => const DataCell(Text('-'))),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount;

  @override
  int get selectedRowCount => 0;
}
