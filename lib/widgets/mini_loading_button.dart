import '/exporter/exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


enum ButtonSize {
  small,
  medium,
  large;

  double get width {
    switch (this) {
      case ButtonSize.small:
        return 140;
      case ButtonSize.medium:
        return 200;
      case ButtonSize.large:
        return 300;
    }
  }

  double get height {
    switch (this) {
      case ButtonSize.small:
        return 40;
      case ButtonSize.medium:
        return 50;
      case ButtonSize.large:
        return 60;
    }
  }

  double get fontSize {
    switch (this) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 17;
      case ButtonSize.large:
        return 19;
    }
  }
}

class MiniLoadingButton extends StatelessWidget {
  const MiniLoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.size = ButtonSize.small,
    this.backgroundColor = const Color(0xFF007BFF),
    this.textColor = Colors.white,
    this.borderRadius = 8,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;
  final ButtonSize size;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          enabled && !isLoading
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap:
            enabled && !isLoading
                ? () {
                  HapticFeedback.lightImpact();
                  FocusScope.of(context).unfocus();
                  onPressed();
                }
                : null,
        child: Container(
          width: size.width.h,
          height: size.height.h,
          decoration: BoxDecoration(
            color: enabled ? backgroundColor : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child:
                isLoading
                    ? SizedBox(
                      width: 18.h,
                      height: 18.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.adaptSize,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(
                      text,
                      style: TextStyle(
                        fontSize: size.fontSize.fSize,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
