import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/core/logger.dart';
import 'package:taproot_admin/features/order_screen/data/order_detail_add.model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_pick_upload_preview.dart';

enum ImageWidgetState { upload, replace, delete }

class ImageRowContainer extends StatefulWidget {
  final String title;
  final String userCode;
  final String imageType;
  final Function(ImageSource imageSource) onImageChanged;

  const ImageRowContainer({
    super.key,
    required this.userCode,
    required this.title,
    required this.imageType,
    required this.onImageChanged,
  });

  @override
  State<ImageRowContainer> createState() => _ImageRowContainerState();
}

class _ImageRowContainerState extends State<ImageRowContainer> {
  Uint8List? previewBytes;
  String? imageUrl;
  ImageWidgetState imageState = ImageWidgetState.upload;

  PortfolioDataModel? portfolio;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPortfolio();
  }

  Future<void> fetchPortfolio() async {
    setState(() => isLoading = true);
    try {
      final result = await PortfolioService.getPortfolio(
        userid: widget.userCode,
      );
      if (result != null) {
        portfolio = result;
        ImageDetails? imageDetails;
        String? imageKey;
        switch (widget.imageType) {
          case 'companyLogo':
            if (portfolio?.workInfo.companyLogo != null) {
              imageDetails = ImageDetails(
                key: portfolio!.workInfo.companyLogo!.key,
                name: portfolio!.workInfo.companyLogo!.name.toString(),
                mimetype: portfolio!.workInfo.companyLogo!.mimetype.toString(),
                size: portfolio!.workInfo.companyLogo!.size!.toInt(),
              );
            }
            break;
          case 'profilePicture':
            if (portfolio?.personalInfo.profilePicture != null) {
              imageDetails = ImageDetails(
                key: portfolio!.personalInfo.profilePicture!.key,
                name: portfolio!.personalInfo.profilePicture!.name.toString(),
                mimetype:
                    portfolio!.personalInfo.profilePicture!.mimetype.toString(),
                size: portfolio!.personalInfo.profilePicture!.size!.toInt(),
              );
            }
            break;
        }

        if (imageDetails != null) {
          imageUrl = getPortfolioImageUrl(imageDetails.key);
          imageState = ImageWidgetState.replace;

          widget.onImageChanged(
            ImageSource(image: imageDetails, source: 'portfolio'),
          );
        } else {
          widget.onImageChanged(ImageSource(source: 'none'));
        }
      }
    } catch (e) {
      logError(e.toString());
      if (mounted && (e is! CustomException || (e.statusCode != 404))) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _pickAndUploadImage() async {
    logWarning('Picking image...');

    try {
      final picked = await ImagePickerService.pickImage();

      if (picked == null) {
        logWarning('No image picked or incomplete image data.');
        return;
      }

      setState(() {
        previewBytes = picked.bytes;
        imageState = ImageWidgetState.replace;
      });

      final uploaded = await ImagePickerService.uploadImageFile(
        picked.bytes,
        picked.filename,
      );

      final imageDetails = ImageDetails(
        key: uploaded.key,
        name: uploaded.name,
        mimetype: uploaded.mimeType,
        size: uploaded.size,
      );

      final newImageUrl = getPortfolioImageUrl(imageDetails.key);

      setState(() {
        imageUrl = newImageUrl;
        imageState = ImageWidgetState.replace;
      });

      widget.onImageChanged(ImageSource(image: imageDetails, source: 'order'));
    } catch (e, stackTrace) {
      logError('Image picking or upload failed: $e\n$stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  void _removeImage() {
    setState(() {
      previewBytes = null;
      imageUrl = null;
      imageState = ImageWidgetState.upload;
    });

    widget.onImageChanged(ImageSource(source: 'none'));
  }

  String? getPortfolioImageUrl(String? key) {
    if (key == null) return null;
    return '$baseUrl/file?key=portfolios/$key';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    String label;
    IconData icon;

    switch (imageState) {
      case ImageWidgetState.upload:
      case ImageWidgetState.delete:
        label = 'Upload';
        icon = LucideIcons.upload;
        break;
      case ImageWidgetState.replace:
        label = 'Replace';
        icon = LucideIcons.repeat;
        break;
    }

    return ImageContainer(
      title: widget.title,
      icon: icon,
      imageState: label,
      imageUrl: imageUrl,
      previewBytes: previewBytes,
      isEdit: true,
      onTap: _pickAndUploadImage,
      onTapRemove: _removeImage,
    );
  }
}
