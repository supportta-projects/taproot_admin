import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

Future<bool> showConfirmationDialog(BuildContext context, String action,String message) async {
  return await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: CustomColors.secondaryColor,
              title: Text('$message $action', style: context.inter60020),
              content: const Text(
                'This action cannot be undone. Proceed anyway?',
              ),
              actions: [
                MiniGradientBorderButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                MiniLoadingButton(
                  useGradient: true,
                  needRow: false,
                  text: 'Yes',
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
      ) ??
      false;
}
