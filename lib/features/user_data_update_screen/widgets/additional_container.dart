import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/launch_url.dart';

import '../../users_screen/data/user_data_model.dart';

class AdditionalContainer extends StatefulWidget {
  final PortfolioDataModel? portfolio;

  final bool isEdit;
  final User user;
  const AdditionalContainer({
    super.key,
    required this.user,
    this.isEdit = false,
    this.portfolio,
  });

  @override
  State<AdditionalContainer> createState() => _AdditionalContainerState();
}

class _AdditionalContainerState extends State<AdditionalContainer> {
  File? selectedImageLoco;
  File? selectedImageBanner;

  void _pickImage({required bool isLogo}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        if (isLogo) {
          selectedImageLoco = File(result.files.first.path!);
        } else {
          selectedImageBanner = File(result.files.first.path!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      // height: SizeUtils.height * 0.35,
      title: 'Additional Details',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  widget.isEdit
                      ? TextFormContainer(
                        initialValue: widget.portfolio!.workInfo.primaryWebsite,
                        labelText: 'Website Link',
                        user: widget.user,
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value:
                            widget.portfolio?.workInfo. primaryWebsite ?? 'loading....',
                        ontap:
                            () => launchWebsiteLink(
                              widget.portfolio?.workInfo. primaryWebsite ?? '',
                              context,
                            ),
                      ),
                  widget.isEdit
                      ? TextFormContainer(
                        initialValue: widget.portfolio!.workInfo. secondaryWebsite,
                        labelText: 'Website Link',
                        user: widget.user,
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value: widget.portfolio?.workInfo. secondaryWebsite ?? '-',
                        ontap:
                            () => launchWebsiteLink(
                              widget.portfolio?.workInfo. secondaryWebsite ?? '',
                              context,
                            ),
                      ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: CustomPadding.paddingXL),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      widget.isEdit
                          ? ImageContainer(
                            selectedFile: selectedImageLoco,
                            isEdit: true,
                            icon:
                                selectedImageLoco == null
                                    ? LucideIcons.upload
                                    : LucideIcons.repeat,
                            title: 'Loco',
                            onTap: () => _pickImage(isLogo: true),
                            imageState:
                                selectedImageLoco == null
                                    ? 'Upload'
                                    : 'Replace',
                          )
                          : ImageContainer(
                            onTap: () {},
                            isEdit: false,
                            title: 'Loco',
                            icon: LucideIcons.upload,
                            imageState: 'Upload',
                            selectedFile: null,
                          ),
                      widget.isEdit
                          ? ImageContainer(
                            onTap: () => _pickImage(isLogo: false),
                            isEdit: true,
                            title: 'Banner Image',
                            icon:
                                selectedImageBanner == null
                                    ? LucideIcons.upload
                                    : LucideIcons.repeat,
                            imageState:
                                selectedImageBanner == null
                                    ? 'Upload'
                                    : 'Replace',
                            selectedFile: selectedImageBanner,
                          )
                          : ImageContainer(
                            onTap: () {},
                            icon: LucideIcons.upload,
                            title: 'Banner Image',
                            imageState: 'Upload',
                            selectedFile: null,
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
