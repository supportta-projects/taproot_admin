

import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class AddImageContainer extends StatelessWidget {
  
  const AddImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: CustomPadding.paddingLarge.v),
      child: Container(
        width: 200.v,
        height: 150.h,
        decoration: BoxDecoration(
          color: CustomColors.lightGreen,
          borderRadius: BorderRadius.circular(CustomPadding.padding.v),
        ),
        child: Center(
          child: Icon(Icons.add, size: 40.v, color: CustomColors.greenDark),
        ),
      ),
    );
  }
}
