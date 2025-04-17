import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/users_screen/model/user_data_model.dart';

class TextFormContainer extends StatelessWidget {
  final String initailValue;
  final bool readonly;
  final String labelText;
  const TextFormContainer({
    super.key,
    required this.initailValue,
    required this.labelText,
    required this.user,
    this.readonly = false,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingLarge.v,
        vertical: CustomPadding.padding.v,
      ),
      child: TextFormField(
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
