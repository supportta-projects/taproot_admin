import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_service.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Future<void> addUser() async {
    final result = await UserService.createUser(
      userData: {'name': nameController.text, 'email': emailController.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600.v,
        height: 370.v,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70.v,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(CustomPadding.paddingLarge.v),
                  topRight: Radius.circular(CustomPadding.paddingLarge.v),
                ),
                color: CustomColors.burgandryRed,
              ),
              child: Center(
                child: Text(
                  'Add User',
                  style: context.inter60014.copyWith(
                    color: CustomColors.backgroundColor,
                  ),
                ),
              ),
            ),

            Gap(CustomPadding.paddingXL.v),

            TextFormContainer(
              labelText: 'Full Name',
              controller: nameController,
            ),
            Gap(CustomPadding.paddingLarge.v),
            TextFormContainer(labelText: 'Email', controller: emailController),
            Gap(CustomPadding.paddingLarge.v),

            MiniLoadingButton(
              needRow: false,
              text: 'Add',
              onPressed: () {
                addUser();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account added successfully!')),
                );

                // TODO: Handle add action
              },
              useGradient: true,
              gradientColors: CustomColors.borderGradient.colors,
            ),
          ],
        ),
      ),
    );
  }
}
