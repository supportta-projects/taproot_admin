import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart' as order_details;

class ImageContainerWithHead extends StatelessWidget {
  const ImageContainerWithHead({
    super.key,
    required this.orderDetails,
    required this.heading,
    required this.imageKey,
    this.isOrderImage = false,
  });

  final order_details.OrderDetails? orderDetails;
  final String heading;
  final String imageKey;
  final bool isOrderImage;

  @override
  Widget build(BuildContext context) {
    // final imagePath = isOrderImage ? 'orders' : 'portfolios';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text(heading)]),
        Gap(CustomPadding.paddingLarge.v),

        Row(
          children: [
            Gap(CustomPadding.paddingXL.v),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  CustomPadding.paddingLarge.v,
                ),
              ),
              width: 200,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  CustomPadding.paddingLarge.v,
                ),
                child: Image.network('$baseUrl/file?key=portfolios/$imageKey'),
              ),
            ),
          ],
        ),
        Gap(CustomPadding.paddingXL.v),
      ],
    );
  }
}
