import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  const SearchWidget({super.key,required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeUtils.width / 3.h,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.inter40016.copyWith(color: CustomColors.hintGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
          suffixIcon: Icon(LucideIcons.search),
        ),
      ),
    );
  }
}
