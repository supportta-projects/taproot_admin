import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogisticTileWidget extends StatelessWidget {
  final double tileWidgetBorderRadius;
  final int numericaldata;
  final double normalPadding;
  final Widget? supportingWidget;
  final Icon? trailingIcon;
  const LogisticTileWidget({
    super.key,
    required this.tileWidgetBorderRadius,
    required this.normalPadding,
    this.supportingWidget,
    required this.numericaldata,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tileWidgetBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(normalPadding * 2),
        child: Row(
          children: [
            // Left side: Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Important to prevent overflow
                children: [
                  Text(
                    'Total Orders',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '$numericaldata',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(normalPadding),
                      supportingWidget ?? SizedBox(),
                    ],
                  ),
                ],
              ),
            ),

            // Right side: Icon
            trailingIcon ?? Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
