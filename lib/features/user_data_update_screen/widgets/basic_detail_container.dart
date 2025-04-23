import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/test_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row_copy.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';
import 'package:taproot_admin/widgets/gradient_text.dart';

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
        isEdit
            ? SizedBox()
            : DetailRowCopy(
              label: 'Portfolio Link',
              value: 'https://docs.google.com',
              icon: Icons.copy,
            ),
        isEdit ? SizedBox() : Gap(CustomPadding.padding.v),
        isEdit
            ? SizedBox()
            : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  Text(
                    'QR Code',
                    style: context.inter50014.copyWith(fontSize: 14.fSize),
                  ),
                  Spacer(),
                  GradientText(
                    'Download',
                    gradient: CustomColors.borderGradient,
                    style: context.inter50014.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: CustomColors.greenDark,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

class TextFormContainer extends StatelessWidget {
  final String initailValue;
  final int maxline;
  final bool readonly;
  final String labelText;
  final User? user;
  const TextFormContainer({
    super.key,
    required this.initailValue,
    required this.labelText,
    this.user,
    this.readonly = false,
    this.maxline = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingLarge.v,
        vertical: CustomPadding.padding.v,
      ),
      child: TextFormField(
        maxLines: maxline,
        readOnly: readonly,
        initialValue: initailValue,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
