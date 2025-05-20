import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/launch_url.dart';

import '../../users_screen/data/user_data_model.dart';

class AdditionalContainer extends StatefulWidget {
  final TextEditingController? primaryWebsiteController;
  final TextEditingController? secondaryWebsiteController;
  final PortfolioDataModel? portfolio;
  final bool isEdit;
  final User user;
  final String? bannerImageUrl;
  final String? logoImageUrl;
  final Function(PlatformFile file)? onLogoSelected;    // Add these callbacks
  final Function(PlatformFile file)? onBannerSelected;

  const AdditionalContainer({
    super.key,
    required this.user,
    this.isEdit = false,
    this.portfolio,
    this.primaryWebsiteController,
    this.secondaryWebsiteController,
    this.bannerImageUrl,
    this.logoImageUrl,
    this.onLogoSelected,
    this.onBannerSelected
  });

  @override
  State<AdditionalContainer> createState() => _AdditionalContainerState();
}

class _AdditionalContainerState extends State<AdditionalContainer> {
  PlatformFile? pickedLogoImage;
  PlatformFile? pickedBannerImage;
  Uint8List? previewLogoBytes;
  Uint8List? previewBannerBytes;


void _pickImage({required bool isLogo}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (isLogo) {
            pickedLogoImage = result.files.first;
            previewLogoBytes = pickedLogoImage!.bytes;
            widget.onLogoSelected?.call(pickedLogoImage!); // Notify parent
          } else {
            pickedBannerImage = result.files.first;
            previewBannerBytes = pickedBannerImage!.bytes;
            widget.onBannerSelected?.call(pickedBannerImage!); // Notify parent
          }
        });
      }
    } catch (e) {
      logError('Error picking or uploading image: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error selecting image: $e')));
      }
    }
  }

  // void _pickImage({required bool isLogo}) async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowedExtensions: ['jpg', 'jpeg', 'png'],
  //       withData: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       setState(() {
  //         if (isLogo) {
  //           pickedLogoImage = result.files.first;
  //           previewLogoBytes = pickedLogoImage!.bytes;
  //         } else {
  //           pickedBannerImage = result.files.first;
  //           previewBannerBytes = pickedBannerImage!.bytes;
  //         }
  //       });

  //       // Upload the image file after picking it
  //       final fileToUpload = isLogo ? pickedLogoImage : pickedBannerImage;
  //       if (fileToUpload?.bytes != null) {
  //         final uploadResult = await PortfolioService.uploadImageFile(
  //           fileToUpload!.bytes!,
  //           fileToUpload.name,
  //         );

  //         logInfo('Upload success: $uploadResult');
  //       }
  //     } else {
  //       logInfo('No image selected.');
  //     }
  //   } catch (e) {
  //     logError('Error picking or uploading image: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
  //     }
  //   }
  // }

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
                  widget.isEdit
                      ? TextFormContainer(
                        controller: widget.primaryWebsiteController,
                        labelText: 'Website Link',
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value:
                            widget.portfolio?.workInfo.primaryWebsite ??
                            'loading....',
                        ontap:
                            () => launchWebsiteLink(
                              widget.portfolio?.workInfo.primaryWebsite ?? '',
                              context,
                            ),
                      ),
                  widget.isEdit
                      ? TextFormContainer(
                        controller: widget.secondaryWebsiteController,
                        labelText: 'Website Link',
                      )
                      : DetailRow(
                        label: 'Website Link',
                        value:
                            widget.portfolio?.workInfo.secondaryWebsite ?? '-',
                        ontap:
                            () => launchWebsiteLink(
                              widget.portfolio?.workInfo.secondaryWebsite ?? '',
                              context,
                            ),
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
                      if (widget.isEdit) ...[
                        ImageContainer( 
                          selectedFile: null,
                          previewBytes: previewLogoBytes,
                          imageUrl: widget.logoImageUrl,
                          isEdit: true,
                          icon:
                              previewLogoBytes == null
                                  ? LucideIcons.upload
                                  : LucideIcons.repeat,
                          title: 'Logo',
                          onTap: () => _pickImage(isLogo: true),
                          imageState:
                              previewLogoBytes == null ? 'Upload' : 'Replace',
                        ),
                        ImageContainer(
                          selectedFile: null,
                          previewBytes: previewBannerBytes,
                          imageUrl: widget.bannerImageUrl,
                          isEdit: true,
                          title: 'Banner Image',
                          icon:
                              previewBannerBytes == null
                                  ? LucideIcons.upload
                                  : LucideIcons.repeat,
                          imageState:
                              previewBannerBytes == null ? 'Upload' : 'Replace',
                          onTap: () => _pickImage(isLogo: false),
                        ),
                      ] else ...[
                        ImageContainer(
                          selectedFile: null,
                          imageUrl: widget.logoImageUrl,
                          isEdit: false,
                          icon: LucideIcons.image,
                          title: 'Logo',
                          onTap: null,
                          imageState: '',
                        ),
                        ImageContainer(
                          selectedFile: null,
                          imageUrl: widget.bannerImageUrl,
                          isEdit: false,
                          title: 'Banner Image',
                          icon: LucideIcons.image,
                          imageState: '',
                          onTap: null,
                        ),
                      ],
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

// class _AdditionalContainerState extends State<AdditionalContainer> {
//   File? selectedImageLoco;
//   File? selectedImageBanner;

//   void _pickImage({required bool isLogo}) async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         allowedExtensions: ['jpg', 'jpeg', 'png'],
//       );

//       if (result != null &&
//           result.files.isNotEmpty &&
//           result.files.first.path != null) {
//         setState(() {
//           if (isLogo) {
//             selectedImageLoco = File(result.files.first.path!);
//           } else {
//             selectedImageBanner = File(result.files.first.path!);
//           }
//         });
//       }
//     } catch (e) {
//       logError('Error picking image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CommonUserContainer(
//       title: 'Additional Details',
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   widget.isEdit
//                       ? TextFormContainer(
//                         controller: widget.primaryWebsiteController,
//                         labelText: 'Website Link',
//                       )
//                       : DetailRow(
//                         label: 'Website Link',
//                         value:
//                             widget.portfolio?.workInfo.primaryWebsite ??
//                             'loading....',
//                         ontap:
//                             () => launchWebsiteLink(
//                               widget.portfolio?.workInfo.primaryWebsite ?? '',
//                               context,
//                             ),
//                       ),
//                   widget.isEdit
//                       ? TextFormContainer(
//                         controller: widget.secondaryWebsiteController,
//                         labelText: 'Website Link',
//                       )
//                       : DetailRow(
//                         label: 'Website Link',
//                         value:
//                             widget.portfolio?.workInfo.secondaryWebsite ?? '-',
//                         ontap:
//                             () => launchWebsiteLink(
//                               widget.portfolio?.workInfo.secondaryWebsite ?? '',
//                               context,
//                             ),
//                       ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(top: CustomPadding.paddingXL.v),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Row(
//                     children: [
//                       if (widget.isEdit) ...[
//                         // Edit mode UI
//                         ImageContainer(
//                           selectedFile: selectedImageLoco,
//                           imageUrl: widget.logoImageUrl,
//                           isEdit: true,
//                           icon:
//                               selectedImageLoco == null
//                                   ? LucideIcons.upload
//                                   : LucideIcons.repeat,
//                           title: 'Logo',
//                           onTap: () => _pickImage(isLogo: true),
//                           imageState:
//                               selectedImageLoco == null ? 'Upload' : 'Replace',
//                         ),
//                         ImageContainer(
//                           imageUrl: widget.bannerImageUrl,
//                           selectedFile: selectedImageBanner,
//                           isEdit: true,
//                           title: 'Banner Image',
//                           icon:
//                               selectedImageBanner == null
//                                   ? LucideIcons.upload
//                                   : LucideIcons.repeat,
//                           imageState:
//                               selectedImageBanner == null
//                                   ? 'Upload'
//                                   : 'Replace',
//                           onTap: () => _pickImage(isLogo: false),
//                         ),
//                       ] else ...[
//                         // View mode UI
//                         ImageContainer(
//                           selectedFile: null,
//                           imageUrl: widget.logoImageUrl,
//                           isEdit: false,
//                           icon: LucideIcons.image,
//                           title: 'Logo',
//                           onTap: null,
//                           imageState: '',
//                         ),
//                         ImageContainer(
//                           imageUrl: widget.bannerImageUrl,
//                           selectedFile: null,
//                           isEdit: false,
//                           title: 'Banner Image',
//                           icon: LucideIcons.image,
//                           imageState: '',
//                           onTap: null,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
