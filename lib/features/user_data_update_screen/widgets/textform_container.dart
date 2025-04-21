import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';

class TextFormContainer extends StatelessWidget {
  final String? initialValue;
  final bool readonly;
  final String? labelText;
  final User? user;

  const TextFormContainer({
    super.key,
    this.initialValue,
    this.labelText,
    this.user,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingLarge.v,
        vertical: CustomPadding.padding.v,
      ),
      child: TextFormField(
        readOnly: readonly,
        initialValue: initialValue,
        decoration: InputDecoration(
          label: labelText != null ? Text(labelText!) : null,
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
