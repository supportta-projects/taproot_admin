import 'package:flutter/material.dart';

import 'model/user_data_model.dart';


class UserManagementScreen extends StatefulWidget {
const UserManagementScreen({super.key});


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
    final rowsPerPage = 8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add User Logic
            },
            label: const Text('Add User'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(width: 16),
                const Text("Premium Users"),
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
          ),
          Expanded(
            child: PaginatedDataTable(
              header: const Text(''),
              rowsPerPage: rowsPerPage,
              availableRowsPerPage: const [8],
              columns: const [
                DataColumn(label: Text('Full Name')),
                DataColumn(label: Text('User ID')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('WhatsApp')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Website Link')),
                DataColumn(label: Text('Premium')),
              ],
              source: UserDataTableSource(filteredUsers),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  final List<User> users;

  UserDataTableSource(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index];
    return DataRow(
      cells: [
        DataCell(Text(user.fullName)),
        DataCell(Text(user.userId)),
        DataCell(Text(user.phone)),
        DataCell(Text(user.whatsapp)),
        DataCell(Text(user.email)),
        DataCell(Text(user.website)),
        DataCell(
          Switch(
            value: user.isPremium,
            onChanged: null, // disabled toggle
          ),
        ),
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
