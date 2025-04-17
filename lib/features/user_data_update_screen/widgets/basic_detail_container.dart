import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';

class BasicDetailContainer extends StatelessWidget {
  final bool isEdit;
  const BasicDetailContainer({
    super.key,
    required this.user,
    this.isEdit = false,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Basic Details',
      children: [
        Gap(CustomPadding.paddingLarge.v),
        isEdit
            ? TextFormContainer(
              user: user,
              initailValue: user.fullName,
              labelText: 'Full Name',
            )
            : DetailRow(label: 'Full Name', value: user.fullName),

        isEdit
            ? TextFormContainer(
              readonly: true,
              user: user,
              initailValue: user.email,
              labelText: 'Email',
            )
            : DetailRow(label: 'Email', value: user.email),
        isEdit
            ? TextFormContainer(
              user: user,
              initailValue: user.phone,
              labelText: 'Phone Number',
            )
            : DetailRow(label: 'Phone Number', value: user.phone),
        isEdit
            ? TextFormContainer(
              user: user,
              initailValue: user.whatsapp,
              labelText: 'WhatsApp Number',
            )
            : DetailRow(label: 'WhatsApp Number', value: user.whatsapp),
      ],
    );
  }
}

class TextFormContainer extends StatelessWidget {
  final String initailValue;
  final int maxline;
  final bool readonly;
  final String labelText;
  const TextFormContainer({
    super.key,
    required this.initailValue,
    required this.labelText,
    required this.user,
    this.readonly = false,
    this.maxline=1
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingLarge.v,
        vertical: CustomPadding.padding.v,
      ),
      child: TextFormField(maxLines: maxline,
        readOnly: readonly,
        initialValue: initailValue,
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: TextStyle(color: CustomColors.textColorDarkGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
        ),
      ),
    );
  }
}
