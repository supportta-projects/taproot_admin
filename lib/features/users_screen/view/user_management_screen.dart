import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/users_screen/data/user_service.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

import '../../user_data_update_screen/views/user_data_update_screen.dart';
import '../data/user_data_model.dart';

class UserManagementScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? innerNavigatorKey;

  const UserManagementScreen({super.key, this.innerNavigatorKey});

  static const path = '/userManagementScreen';

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> users = [];
  bool isLoading = true;
  int currentPage = 1;
  int totalPages = 1;
  int totalUser = 0;
  String searchQuery = '';
  bool showOnlyPremium = false;
  final rowsPerPage = 10;
  UserDataTableSource? _dataSource;

  List<User> get filteredUsers {
    return users.where((user) {
      final matchSearch = user.fullName.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchPremium = showOnlyPremium ? user.isPremium : true;
      return matchSearch && matchPremium;
    }).toList();
  }

  Future<void> loadUsers() async {
    try {
      final response = await UserService.fetchUser(currentPage);
      setState(() {
        users = response.users;
        totalUser = response.totalCount;
        // totalPages = response.totalPages;
        isLoading = false;
        final filtered = filteredUsers;
        _dataSource = UserDataTableSource(
          filtered,
          response.totalCount,
          context,
          widget.innerNavigatorKey,
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception(e);
    }
  }

  @override
  void initState() {
    loadUsers();

    // TODO: implement initState
    super.initState();
  }

  int _firstRowIndex = 0;

  void _handlePageChange(int firstRowIndex) {
    setState(() {
      _firstRowIndex = firstRowIndex;
      currentPage = (_firstRowIndex ~/ rowsPerPage) + 1;
    });
    loadUsers(); // load data for new page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Gap(CustomPadding.paddingLarge.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MiniLoadingButton(
                    icon: Icons.add,
                    text: 'Add User',
                    onPressed: () {},
                    useGradient: true,
                    gradientColors: CustomColors.borderGradient.colors,
                  ),
                  Gap(CustomPadding.paddingXL.v),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomPadding.paddingXL.v,
                  vertical: CustomPadding.paddingLarge.v,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search Uses ID, Name, Number',
                        ),
                        onChanged: (val) {
                          setState(() {
                            searchQuery = val;
                          });
                          loadUsers(); // refresh the data
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: SizeUtils.height * 0.6,
                width: .8 * SizeUtils.width,
                child: PaginatedDataTable(
                  onPageChanged: _handlePageChange,

                  sortColumnIndex: 0,
                  arrowHeadColor: CustomColors.textFieldBorderGrey,
                  // headingRowColor: WidgetStatePropertyAll(
                  //   CustomColors.textFieldBorderGrey,
                  // ),
                  // dragStartBehavior: ,
                  showEmptyRows: false,
                  columnSpacing: CustomPadding.paddingXL.v,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Premium Users",
                          style: context.inter50016.copyWith(
                            fontSize: 16.fSize,
                          ),
                        ),
                        Switch(
                          value: showOnlyPremium,
                          onChanged: (val) {
                            setState(() {
                              showOnlyPremium = val;
                            });
                            loadUsers(); // refresh the data
                          },
                        ),
                      ],
                    ),
                  ],
                  dataRowMaxHeight: 80,
                  header: SizedBox(),
                  horizontalMargin: .06 * SizeUtils.width,
                  rowsPerPage: rowsPerPage,
                  availableRowsPerPage: const [8],
                  columns: const [
                    DataColumn(
                      // headingRowAlignment: ,
                      label: Text('Full Name'),
                    ),
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('WhatsApp')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Website Link')),
                    DataColumn(label: Text('Premium')),
                  ],
                  source:
                      _dataSource ??
                      UserDataTableSource(
                        [],
                        0,
                        context,
                        widget.innerNavigatorKey,
                      ),
                  //  UserDataTableSource(
                  //   filteredUsers,
                  //   context,

                  //   widget.innerNavigatorKey,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  final List<User> users;
  final BuildContext context;
  final GlobalKey<NavigatorState>? innerNavigatorKey;
  final int totalCount;

  UserDataTableSource(
    this.users,
    this.totalCount,
    this.context,
    this.innerNavigatorKey,
  );

  @override
  DataRow getRow(int index) {
    if (index >= users.length) {
      return DataRow(
        cells: [
          DataCell(Text('No data available')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
        ],
      );
    }

    final user = users[index];

    void handleRowTap() {
      logWarning('Row tapped: ${user.fullName}');
      innerNavigatorKey?.currentState?.push(
        MaterialPageRoute(
          builder: (context) => UserDataUpdateScreen(user: user),
        ),
      );
    }

    return DataRow(
      cells: [
        DataCell(
          InkWell(
            onTap: handleRowTap,
            child: Center(child: Text(user.fullName)),
          ),
        ),
        DataCell(
          InkWell(onTap: handleRowTap, child: Center(child: Text(user.userId))),
        ),
        DataCell(
          InkWell(onTap: handleRowTap, child: Center(child: Text(user.phone))),
        ),
        DataCell(
          InkWell(
            onTap: handleRowTap,
            child: Center(child: Text(user.whatsapp)),
          ),
        ),
        DataCell(
          InkWell(onTap: handleRowTap, child: Center(child: Text(user.email))),
        ),
        DataCell(
          InkWell(
            onTap: handleRowTap,
            child: Center(child: Text(user.website)),
          ),
        ),
        DataCell(Switch(value: user.isPremium, onChanged: null)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount;
  @override
  int get selectedRowCount => 0;
}
