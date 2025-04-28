import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/services/size_utils.dart';

import '../../users_screen/user_data_model.dart';

class AdditionalContainer extends StatefulWidget {
  final bool isEdit;
  final User user;
  const AdditionalContainer({
    super.key,
    required this.user,
    this.isEdit = false,
  });

  @override
  State<AdditionalContainer> createState() => _AdditionalContainerState();
}

class _AdditionalContainerState extends State<AdditionalContainer> {
  File? selectedImage;

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedImage = File(result.files.first.path!);
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
                        initialValue: 'https://docs.google.com',
                        labelText: 'Website Link',
                        user: widget.user,
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value: 'https://docs.google.com',
                      ),
                  widget.isEdit
                      ? TextFormContainer(
                        initialValue: '-',
                        labelText: 'Website Link',
                        user: widget.user,
                      )
                      : DetailRow(label: 'Website Link', value: '-'),
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
                            selectedFile: selectedImage, // <-- This line added
                            isEdit: true,
                            icon: LucideIcons.upload,
                            title: 'Loco',
                            onTap: _pickImage,
                            imageState: 'Upload',
                          )
                          : ImageContainer(
                            onTap: () {},
                            isEdit: false,
                            title: 'Loco',
                            icon: LucideIcons.upload,
                            imageState: 'Upload',
                            selectedFile:
                                null, // <- Not necessary but can be null
                          ),
                      ImageContainer(
                        onTap: () {},
                        isEdit: true,
                        title: 'Banner Image',
                        icon: LucideIcons.repeat,
                        imageState: 'Replace',
                        selectedFile: null, // <- Provide null
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
