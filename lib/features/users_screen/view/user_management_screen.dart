import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/users_screen/data/user_service.dart';
import 'package:taproot_admin/features/users_screen/widget/adduser_dialog.dart';
import 'package:taproot_admin/widgets/gradient_text.dart';
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
  int premiumUsers = 0;
  final rowsPerPage = 10;
  UserDataTableSource? _dataSource;
  final _tableKey = GlobalKey<PaginatedDataTableState>();

  Future<void> loadUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await UserService.fetchUser(
        currentPage,
        searchQuery,
        showOnlyPremium,
      );

      if (!mounted) return;

      setState(() {
        users = response.users;
        premiumUsers = users.where((user) => user.isPremium).length;
        totalUser = response.totalCount;
        totalPages = (totalUser / rowsPerPage).ceil();
        isLoading = false;

        final filtered =
            users.where((user) {
              final query = searchQuery.toLowerCase();
              final matchName = user.fullName.toLowerCase().contains(query);
              final matchNumber = user.phone.toLowerCase().contains(query);
              final matchUserId = user.userId.toLowerCase().contains(query);
              final matchWhatsapp = user.whatsapp.toLowerCase().contains(query);
              final matchSearch =
                  matchName || matchNumber || matchWhatsapp || matchUserId;
              final matchPremium = showOnlyPremium ? user.isPremium : true;
              return matchSearch && matchPremium;
            }).toList();

        _dataSource = UserDataTableSource(
          filtered,
          totalUser,
          context,
          widget.innerNavigatorKey,
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load users: $e')));
    }
  }

  void refreshList() {
    setState(() {
      currentPage = 1;
      if (_tableKey.currentState != null) {
        _tableKey.currentState!.pageTo(0);
      }
    });
    loadUsers();
  }


  void _handlePageChange(int firstRowIndex) {
    // if (!mounted) return;

    final newPage = (firstRowIndex / rowsPerPage).floor() + 1;

    if (newPage != currentPage && newPage <= totalPages) {
      setState(() {
        currentPage = newPage;
      });
      loadUsers();
    }
  }

  @override
  void initState() {
    loadUsers();

    // TODO: implement initState
    super.initState();
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (dialogContext) =>
                                AddUserDialog(onCallFunction: refreshList),
                      );
                    },
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
                            _tableKey.currentState?.pageTo(0);
                          });
                          loadUsers();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: .8 * SizeUtils.width,
                child: PaginatedDataTable(
                  key: _tableKey,
                  headingRowColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    return Colors.transparent;
                  }),
                  onPageChanged: _handlePageChange,

                  sortColumnIndex: 0,
                  //TODO
                  arrowHeadColor: CustomColors.borderGradient.colors.first,

                  showEmptyRows: false,
                  columnSpacing: CustomPadding.paddingXL.v,
                  actions: [
                    Text(
                      "Premium Users",
                      style: context.inter50016.copyWith(fontSize: 16.fSize),
                    ),
                    Switch(
                      value: showOnlyPremium,
                      onChanged: (val) {
                        setState(() {
                          showOnlyPremium = val;
                          _tableKey.currentState?.pageTo(0);
                        });
                        loadUsers(); // refresh the data
                      },
                    ),
                  ],
                  dataRowMaxHeight: 60,
                  header: SizedBox(),
                  horizontalMargin: .06 * SizeUtils.width,
                  rowsPerPage: 10,
                  availableRowsPerPage: const [8, 10, 12],
                  // You can customize this if needed
                  showFirstLastButtons: true,
                  columns: [
                    DataColumn(label: Text('User ID')),
                    DataColumn(
                      // headingRowAlignment: ,
                      label: Text('Full Name'),
                    ),

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
                        totalUser,
                        context,
                        widget.innerNavigatorKey,
                      ),
                ),
              ),

              Gap(CustomPadding.paddingXL.v),
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
    // Calculate the actual index within the current page's data
    final actualIndex = index % (users.length + 1);

    if (actualIndex >= (users.length)) {
      return DataRow(
        cells: List<DataCell>.generate(7, (index) => const DataCell(Text(''))),
      );
    }

    final user = users[actualIndex];

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
          InkWell(onTap: handleRowTap, child: Center(child: Text(user.userId))),
        ),
        DataCell(
          InkWell(
            onTap: handleRowTap,
            child: Center(child: Text(user.fullName)),
          ),
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
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.v,
                height: 40.v,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        user.isPremium
                            ? CustomColors.borderGradient.colors.first
                            : CustomColors.greylight,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(CustomPadding.padding.v),
                  color:
                      user.isPremium
                          ? Colors.transparent
                          : CustomColors.greylight,
                ),
                child: Center(
                  child:
                      user.isPremium
                          ? GradientText(
                            'Premium',
                            gradient: CustomColors.borderGradient,
                            style: context.inter50014,
                          )
                          : Text('Base', style: context.inter50014),
                ),
              ),

              // Switch(value: user.isPremium, onChanged: null)
            ],
          ),
        ),
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
