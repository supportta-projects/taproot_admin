import 'package:flutter/material.dart';

class SideNavScreen extends StatefulWidget {
  static const String path = '/sideNav';
  const SideNavScreen({super.key});

  @override
  State<SideNavScreen> createState() => _SideNavScreenState();
}

class _SideNavScreenState extends State<SideNavScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Side Navigation Screen'),
      ),
    );
  }
}