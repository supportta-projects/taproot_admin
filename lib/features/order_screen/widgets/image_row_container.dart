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

enum ImageWidgetState { upload, replace, delete }

class ImageRowContainer extends StatefulWidget {
  final String title;
  final String userCode;

  const ImageRowContainer({
    super.key,
    required this.userCode,
    required this.title,
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
        final imageKey = portfolio?.workInfo.companyLogo?.key;
        if (imageKey != null) {
          imageUrl = getPortfolioImageUrl(imageKey);
          imageState = ImageWidgetState.replace;
        }
      }
    } catch (e) {
      logError(e.toString());
      if (mounted &&
          (e is! CustomException ||
              (e is CustomException && e.statusCode != 404))) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picked = await ImagePickerService.pickImage();
    if (picked != null) {
      setState(() {
        previewBytes = picked.bytes;
        imageState = ImageWidgetState.replace;
      });

      final uploaded = await ImagePickerService.uploadImageFile(
        picked.bytes,
        picked.filename,
      );

      if (uploaded.url.isNotEmpty) {
        setState(() {
          imageUrl = uploaded.url;
          imageState = ImageWidgetState.replace;
        });
      }
    }
  }

  void _removeImage() {
    setState(() {
      previewBytes = null;
      imageUrl = null;
      imageState = ImageWidgetState.upload;
    });
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
        label = 'Upload';
        icon = LucideIcons.upload;
        break;
      case ImageWidgetState.replace:
        label = 'Replace';
        icon = LucideIcons.repeat;
        break;
      case ImageWidgetState.delete:
        label = 'Upload';
        icon = LucideIcons.upload;
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
