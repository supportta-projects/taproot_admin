// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:taproot_admin/exporter/exporter.dart';

// class ImageContainer extends StatelessWidget {
//   final String imageState;
//   final VoidCallback? onTap;
//   final bool isEdit;
//   final String title;
//   final IconData icon;
//   final File? selectedFile;
//   final String? imageUrl;
//   final Uint8List? previewBytes;

//   const ImageContainer({
//     super.key,
//     required this.onTap,
//     this.selectedFile,
//     this.imageUrl,
//     this.previewBytes,
//     required this.icon,
//     required this.title,
//     this.isEdit = false,
//     required this.imageState,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;
//     final hasPreview = previewBytes != null;

//     return SizedBox(
//       width: 160.h,
//       height: 200.v,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title),
//           Gap(CustomPadding.padding.v),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: CustomColors.textColorLightGrey,
//                 borderRadius: BorderRadius.circular(CustomPadding.padding.v),
//               ),
//               width: 140.h,
//               height: 150.v,
//               child: Column(
//                 mainAxisAlignment:
//                     isEdit ? MainAxisAlignment.end : MainAxisAlignment.center,
//                 children: [
//                   if (hasPreview)
//                     Expanded(
//                       child:
//                        ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(CustomPadding.padding.v),
//                           bottom:
//                               isEdit
//                                   ? Radius.zero
//                                   : Radius.circular(CustomPadding.padding.v),
//                         ),
//                         child: Image.memory(
//                           previewBytes!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                       ),
//                     )
//                   else if (hasNetworkImage)
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(CustomPadding.padding.v),
//                           bottom:
//                               isEdit
//                                   ? Radius.zero
//                                   : Radius.circular(CustomPadding.padding.v),
//                         ),
//                         child: Image.network(
//                           imageUrl!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                           errorBuilder:
//                               (context, error, stackTrace) =>
//                                   Icon(LucideIcons.image),
//                         ),
//                       ),
//                     )
//                   else
//                     Icon(
//                       LucideIcons.image,
//                       color: CustomColors.textColorDarkGrey,
//                       size: SizeUtils.height * 0.1,
//                     ),
//                   if (isEdit)
//                     GestureDetector(
//                       onTap: onTap,
//                       child: Container(
//                         width: 140.h,
//                         height: 30.v,
//                         decoration: BoxDecoration(
//                           gradient: CustomColors.borderGradient,
//                           borderRadius: BorderRadius.vertical(
//                             bottom: Radius.circular(CustomPadding.padding.v),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               imageState,
//                               style: context.inter60012.copyWith(
//                                 color: CustomColors.secondaryColor,
//                               ),
//                             ),
//                             Gap(CustomPadding.padding.v),
//                             Icon(
//                               icon,
//                               color: CustomColors.secondaryColor,
//                               size: SizeUtils.height * 0.02,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taproot_admin/exporter/exporter.dart';

class ImageContainer extends StatelessWidget {
  final String imageState;
  final VoidCallback? onTap;
  final bool isEdit;
  final String title;
  final IconData icon;
  final File? selectedFile;
  final String? imageUrl;
  final Uint8List? previewBytes;

  const ImageContainer({
    super.key,
    required this.onTap,
    this.selectedFile,
    this.imageUrl,
    this.previewBytes,
    required this.icon,
    required this.title,
    this.isEdit = false,
    required this.imageState,
  });

  @override
  Widget build(BuildContext context) {
    final hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;
    final hasPreview = previewBytes != null;

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
                  if (hasPreview)
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(CustomPadding.padding.v),
                          bottom:
                              isEdit
                                  ? Radius.zero
                                  : Radius.circular(CustomPadding.padding.v),
                        ),
                        child: Image.memory(
                          previewBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    )
                  else if (hasNetworkImage)
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(CustomPadding.padding.v),
                          bottom:
                              isEdit
                                  ? Radius.zero
                                  : Radius.circular(CustomPadding.padding.v),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(
                                LucideIcons.image,
                                color: CustomColors.textColorDarkGrey,
                              ),
                          memCacheWidth: 140,
                          memCacheHeight: 150,
                          fadeInDuration: const Duration(milliseconds: 300),
                        ),
                      ),
                    )
                  else
                    Icon(
                      LucideIcons.image,
                      color: CustomColors.textColorDarkGrey,
                      size: SizeUtils.height * 0.1,
                    ),
                  if (isEdit)
                    GestureDetector(
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
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ImageContainer extends StatelessWidget {
//   final String imageState;
//   final VoidCallback? onTap;
//   final bool isEdit;
//   final String title;
//   final IconData icon;
//   final File? selectedFile;
//   final String? imageUrl;

//   const ImageContainer({
//     super.key,
//     required this.onTap,
//     this.selectedFile,
//     this.imageUrl,
//     required this.icon,
//     required this.title,
//     this.isEdit = false,
//     required this.imageState,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;

//     return SizedBox(
//       width: 160.h,
//       height: 200.v,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title),
//           Gap(CustomPadding.padding.v),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: CustomColors.textColorLightGrey,
//                 borderRadius: BorderRadius.circular(CustomPadding.padding.v),
//               ),
//               width: 140.h,
//               height: 150.v,
//               child: Column(
//                 mainAxisAlignment:
//                     isEdit ? MainAxisAlignment.end : MainAxisAlignment.center,
//                 children: [
//                   if (selectedFile != null)
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(CustomPadding.padding.v),
//                           bottom:
//                               isEdit
//                                   ? Radius.zero
//                                   : Radius.circular(CustomPadding.padding.v),
//                         ),
//                         child: Image.file(
//                           selectedFile!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                       ),
//                     )
//                   else if (hasNetworkImage)
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(CustomPadding.padding.v),
//                           bottom:
//                               isEdit
//                                   ? Radius.zero
//                                   : Radius.circular(CustomPadding.padding.v),
//                         ),
//                         child: Image.network(
//                           imageUrl!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                           errorBuilder:
//                               (context, error, stackTrace) =>
//                                   Icon(LucideIcons.image),
//                         ),
//                       ),
//                     )
//                   else
//                     Icon(
//                       LucideIcons.image,
//                       color: CustomColors.textColorDarkGrey,
//                       size: SizeUtils.height * 0.1,
//                     ),
//                   // Only show the Upload/Replace button in edit mode
//                   if (isEdit)
//                     GestureDetector(
//                       onTap: onTap,
//                       child: Container(
//                         width: 140.h,
//                         height: 30.v,
//                         decoration: BoxDecoration(
//                           gradient: CustomColors.borderGradient,
//                           borderRadius: BorderRadius.vertical(
//                             bottom: Radius.circular(CustomPadding.padding.v),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               selectedFile != null || hasNetworkImage
//                                   ? 'Replace'
//                                   : 'Upload',
//                               style: context.inter60012.copyWith(
//                                 color: CustomColors.secondaryColor,
//                               ),
//                             ),
//                             Gap(CustomPadding.padding.v),
//                             Icon(
//                               selectedFile != null || hasNetworkImage
//                                   ? LucideIcons.repeat
//                                   : LucideIcons.upload,
//                               color: CustomColors.secondaryColor,
//                               size: SizeUtils.height * 0.02,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
