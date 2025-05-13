

import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class AddImageContainer extends StatelessWidget {
  final bool isImageView;
  final String? path;

  const AddImageContainer({super.key, this.isImageView = false, this.path});

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
        child:
            isImageView
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(CustomPadding.padding.v),
                  child: Image.network(path.toString(), fit: BoxFit.cover),
                )
                : Center(
                  child: Icon(
                    Icons.add,
                    size: 40.v,
                    color: CustomColors.greenDark,
                  ),
                ),
      ),
    );
  }
}
