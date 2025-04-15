import 'package:flutter/material.dart';

class UserDataUpdateScreen extends StatefulWidget {



  final dynamic user;
  static const path = '/userDataUpdateScreen';
  const UserDataUpdateScreen({super.key, required this.user});

  @override
  State<UserDataUpdateScreen> createState() => _UserDataUpdateScreenState();
}

class _UserDataUpdateScreenState extends State<UserDataUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User Data Update Screen'),
      ),
    );
  }
}