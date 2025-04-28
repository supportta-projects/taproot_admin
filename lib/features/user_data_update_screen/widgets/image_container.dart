import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class ImageContainer extends StatelessWidget {
  final String imageState;
  final VoidCallback? onTap;
  final bool isEdit;
  final String title;
  final IconData icon;
  File? selectedFile;

  ImageContainer({
    super.key,
    required this.onTap,
    this.selectedFile,
    required this.icon,
    required this.title,
    this.isEdit = false,
    required this.imageState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.h,
      height: 200.v,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Gap(CustomPadding.padding.v),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.textColorLightGrey,
                borderRadius: BorderRadius.circular(CustomPadding.padding.v),
              ),
              width: 140.h,
              height: 150.v,
              child: Column(
                mainAxisAlignment:
                    isEdit ? MainAxisAlignment.end : MainAxisAlignment.center,
                children: [
                  selectedFile != null
                      ? Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(CustomPadding.padding.v),
                          ),
                          child: Image.file(
                            selectedFile!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      )
                      : Icon(
                        LucideIcons.image,
                        color: CustomColors.textColorDarkGrey,
                        size: SizeUtils.height * 0.1,
                      ),

                  isEdit
                      ? GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: 140.h,
                          height: 30.v,
                          decoration: BoxDecoration(
                            gradient: CustomColors.borderGradient,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(CustomPadding.padding.v),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                imageState,
                                style: context.inter60012.copyWith(
                                  color: CustomColors.secondaryColor,
                                ),
                              ),
                              Gap(CustomPadding.padding.v),
                              Icon(
                                icon,
                                color: CustomColors.secondaryColor,
                                size: SizeUtils.height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
