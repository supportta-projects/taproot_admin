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
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },

            child: Text('Click here to go back to the previous screen'),
          ),
          // Add your form fields here
        ],
      ),
    );
  }
}
