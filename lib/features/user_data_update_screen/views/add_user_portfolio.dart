import 'package:flutter/material.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddUserPortfolio extends StatelessWidget {
  const AddUserPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              MiniLoadingButton(
                icon: Icons.edit,
                text: 'Add',
                onPressed: () {
                  Navigator.pop(context);
                },
                useGradient: true,
                gradientColors: CustomColors.borderGradient.colors,
              ),
            ],
          ),
          Center(child: Text('Add Products')),
        ],
      ),
    );
  }
}
