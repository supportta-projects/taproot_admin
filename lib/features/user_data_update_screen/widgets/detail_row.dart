import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: CustomPadding.paddingLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.inter50014.copyWith(fontSize: 14.fSize)),
          Text(
            value,
            style: context.inter50014.copyWith(
              fontSize: 14.fSize,
              color: CustomColors.textFieldBorderGrey,
            ),
          ),
        ],
      ),
    );
  }
}
