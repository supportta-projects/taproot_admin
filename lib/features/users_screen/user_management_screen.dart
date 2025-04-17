import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

import '../user_data_update_screen/views/user_data_update_screen.dart';
import 'model/user_data_model.dart';

class UserManagementScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? innerNavigatorKey;

  const UserManagementScreen({super.key, this.innerNavigatorKey});

  static const path = '/userManagementScreen';

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> users = List.generate(
    20,
    (index) => User(
      fullName: 'Santhosh Kumar',
      userId: '9123456789',
      phone: '9123456789',
      whatsapp: '9123456789',
      email: 'harshvardhan@gmail.com',
      website: 'supportasolutions.com',
      isPremium: index % 2 == 0,
    ),
  );

  String searchQuery = '';
  bool showOnlyPremium = false;

  List<User> get filteredUsers {
    return users.where((user) {
      final matchSearch = user.fullName.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchPremium = showOnlyPremium ? user.isPremium : true;
      return matchSearch && matchPremium;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final rowsPerPage = 11;

    return Scaffold(
      body: SizedBox(
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
                  gradientColors: [Color(0xff005624), Color(0xff27AE60)],
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
                        style: context.inter50016.copyWith(fontSize: 16.fSize),
                      ),
                      Switch(
                        value: showOnlyPremium,
                        onChanged: (val) {
                          setState(() {
                            showOnlyPremium = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
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
                source: UserDataTableSource(
                  filteredUsers,
                  context,

                  widget.innerNavigatorKey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  final List<User> users;
  final BuildContext context;
  final GlobalKey<NavigatorState>? innerNavigatorKey;

  UserDataTableSource(this.users, this.context, this.innerNavigatorKey);

  @override
  DataRow getRow(int index) {
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
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.fullName))),
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.userId))),
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.phone))),
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.whatsapp))),
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.email))),
        DataCell(InkWell(onTap: handleRowTap, child: Text(user.website))),
        DataCell(Switch(value: user.isPremium, onChanged: null)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
