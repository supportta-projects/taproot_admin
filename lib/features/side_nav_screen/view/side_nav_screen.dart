import 'package:flutter/material.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/services/size_utils.dart';

import '../widgets/custom_side_bar.dart';

class SideNavScreen extends StatefulWidget {
  static const String path = '/sideNav';
  const SideNavScreen({super.key});

  @override
  State<SideNavScreen> createState() => _SideNavScreenState();
}

class _SideNavScreenState extends State<SideNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(
      height: SizeUtils.height,
      width: SizeUtils.width,
      color: Colors.red,

      child: Text('Home'),
    ),
    Center(child: Text('Settings')),
  ];

  void _onItemSelected(int index) {
    logInfo('Tapped index: $index');
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Side Navigation')),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          CustomSideBar(
            selectedIndex: _selectedIndex,
            onItemTap: _onItemSelected,
          ),
        ],
      ),
    );
  }
}
