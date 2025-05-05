import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';

class AddAdditionalDetails extends StatefulWidget {
  final TextEditingController primaryWebsitecontroller;
  final TextEditingController secondaryWebsitecontroller;
  const AddAdditionalDetails({super.key,required this.primaryWebsitecontroller,required this.secondaryWebsitecontroller});

  @override
  State<AddAdditionalDetails> createState() => _AddAdditionalDetailsState();
}

class _AddAdditionalDetailsState extends State<AddAdditionalDetails> {
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
      title: 'Additional Details',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormContainer(controller:widget.primaryWebsitecontroller,
                    initialValue: '',
                    labelText: 'Website Link',
                  ),
                  TextFormContainer(controller:widget.secondaryWebsitecontroller,
                    initialValue: '',
                    labelText: 'Website Link',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: CustomPadding.paddingXL.v),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      ImageContainer(
                        selectedFile: selectedImageLoco,
                        isEdit: true,
                        icon:
                            selectedImageLoco == null
                                ? LucideIcons.upload
                                : LucideIcons.repeat,
                        title: 'Loco',
                        onTap: () => _pickImage(isLogo: true),
                        imageState:
                            selectedImageLoco == null ? 'Upload' : 'Replace',
                      ),
                      ImageContainer(
                        onTap: () => _pickImage(isLogo: false),
                        isEdit: true,
                        title: 'Banner Image',
                        icon:
                            selectedImageBanner == null
                                ? LucideIcons.upload
                                : LucideIcons.repeat,
                        imageState:
                            selectedImageBanner == null ? 'Upload' : 'Replace',
                        selectedFile: selectedImageBanner,
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
