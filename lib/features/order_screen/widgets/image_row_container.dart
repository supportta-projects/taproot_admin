import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_pick_upload_preview.dart';

// enum ImageWidgetState { upload, delete, replace }

class ImageRowContainer extends StatefulWidget {
  final String title;
  final String userCode;
  const ImageRowContainer({super.key, required this.userCode,required this.title});

  @override
  State<ImageRowContainer> createState() => _ImageRowContainerState();
}

class _ImageRowContainerState extends State<ImageRowContainer> {
  PickedImage? pickedImage;
  Uint8List? companyLogoPreviewBytes;
  String? companyLogoImageUrl;
  String companyLogoUploadState = 'Upload';

  Uint8List? profileImagePreviewBytes;
  String? profileImageImageUrl;
  String profileImageUploadState = 'Upload';
  PortfolioDataModel? portfolio;
  bool isLoading = false;

  void _pickAndUploadImage({required bool isCompanyLogo}) async {
    final picked = await ImagePickerService.pickImage();
    if (picked != null) {
      setState(() {
        if (isCompanyLogo) {
          companyLogoPreviewBytes = picked.bytes;

          companyLogoUploadState = 'Replace';
        } else {
          profileImagePreviewBytes = picked.bytes;
          profileImageUploadState = 'Replace';
        }
      });

      final uploaded = await ImagePickerService.uploadImageFile(
        picked.bytes,
        picked.filename,
      );
      setState(() {
        if (isCompanyLogo) {
          companyLogoImageUrl = uploaded.url;
          companyLogoUploadState = 'Uploaded';
        } else {
          profileImageImageUrl = uploaded.url;
          profileImageUploadState = 'Uploaded';
        }
      });
    }
  }

  Future fetchPortfolio() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await PortfolioService.getPortfolio(
        userid: widget.userCode,
      );

      if (result != null) {
        setState(() {
          portfolio = result;

          if (portfolio?.workInfo.companyLogo?.key != null) {
            companyLogoUploadState = 'Replace';
          }
          if (portfolio?.personalInfo.profilePicture?.key != null) {
            profileImageUploadState = 'Replace';
          }
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        if (e is CustomException && e.statusCode == 404) {
        } else {
          logError(e.toString());

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        }
      }
    }
  }

  String? getPortfolioImageUrl(String? key) {
    if (key == null) return null;
    return '$baseUrl/file?key=portfolios/$key';
  }

  @override
  void initState() {
    fetchPortfolio();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ImageContainer(
      imageUrl:
          companyLogoImageUrl ??
          getPortfolioImageUrl(portfolio?.workInfo.companyLogo?.key),
      isEdit: true,
      previewBytes: companyLogoPreviewBytes,
      onTap: () => _pickAndUploadImage(isCompanyLogo: true),
      icon:
          portfolio?.workInfo.companyLogo?.key != null ||
                  companyLogoImageUrl != null
              ? LucideIcons.upload
              : LucideIcons.repeat,
      title:widget.title,
      imageState: companyLogoUploadState,
      onTapRemove: () {},
    );
  }
}
