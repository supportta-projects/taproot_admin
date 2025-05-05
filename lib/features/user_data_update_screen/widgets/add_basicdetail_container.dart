import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';

class AddBasicDetailContainer extends StatelessWidget {
  final TextEditingController namecontroller;
  final TextEditingController emailcontroller;
  final TextEditingController phonecontroller;
  final TextEditingController whatsappcontroller;

  const AddBasicDetailContainer({
    super.key,
    required this.namecontroller,
    required this.emailcontroller,
    required this.phonecontroller,
    required this.whatsappcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Basic Details',
      children: [
        Gap(CustomPadding.paddingLarge.v),

        TextFormContainer(
          controller: namecontroller,
          initialValue: '',
          labelText: 'Full Name',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Full Name is required';
            }
            return null;
          },
        ),
        TextFormContainer(
          controller: emailcontroller,
          initialValue: '',
          labelText: 'Email',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
        TextFormContainer(
          isNumberField: true,
          initialValue: '',
          controller:
              phonecontroller, // Using the controller to handle the phone number input
          labelText: 'Phone Number',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Phone number is required';
            }
            if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
              return 'Enter a valid 10-digit phone number';
            }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),

        TextFormContainer(
          isNumberField: true,
          controller: whatsappcontroller,
          initialValue: '',
          labelText: 'WhatsApp Number',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Phone number is required';
            }
            if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
              return 'Enter a valid 10-digit phone number';
            }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ],
    );
  }
}
