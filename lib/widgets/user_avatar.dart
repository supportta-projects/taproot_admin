// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';


class UserAvatar extends StatelessWidget {
  UserAvatar({
    super.key,
    
    this.imageUrl,
    this.size = CustomPadding.paddingXL,
    this.imageKey,
    this.errorImage,
    this.imageFile,
  });

  String? imageUrl;
  final double size;
  final String? imageKey;
  String? errorImage;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    // errorImage ??= Icons.error.codePoint;
    if (imageUrl != null &&
        imageUrl!.isNotEmpty &&
        imageUrl!.contains("localhost")) {
      // imageUrl = imageUrl!.replaceAll("localhost", appConfig.domain);
    }
    bool isBytes = imageUrl?.startsWith("b'") == true;

    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Builder(
          builder: (context) {
            if (isBytes && (imageUrl != null)) {
              return Image.memory(
                base64Decode(imageUrl!.substring(2, imageUrl!.length - 1)),
                fit: BoxFit.cover,
              );
            }
            if (imageFile != null) {
              return Image.file(imageFile!, fit: BoxFit.cover);
            }

            return CachedNetworkImage(
              cacheKey: imageKey,
              errorWidget:
                  (context, url, error) =>
                      Image.asset(errorImage!, fit: BoxFit.cover),
              imageUrl: imageUrl ?? "",
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
