import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.orderEdit,
    required this.discountPrice,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.categoryName,
    required this.productName,
    required this.image,
  });
  final double price;
  final String productName;
  final double discountPrice;
  final bool orderEdit;
  final String categoryName;
  final int quantity;
  final String image;

  final double totalPrice;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String formatPrice(double price) {
    String priceStr = price.toString();
    if (priceStr.contains('.')) {
      List<String> parts = priceStr.split('.');
      if (parts[1].length > 2) {
        // More than 2 decimals: truncate to 2
        return '${parts[0]}.${parts[1].substring(0, 2)}';
      } else if (parts[1].length == 1) {
        // Only 1 decimal: add trailing zero
        return '${parts[0]}.${parts[1]}0';
      }
    }
    return priceStr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 250,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.productName, style: context.inter60020),
                Gap(CustomPadding.paddingLarge.v),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: CustomPadding.paddingXXL.v,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,

                    borderRadius: BorderRadius.circular(
                      CustomPadding.padding.v,
                    ),
                  ),
                  width: double.infinity,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      CustomPadding.padding.v,
                    ),
                    child: Image.network(
                      '$baseUrl/file?key=products/${widget.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: CustomPadding.paddingLarge.v,
            ),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardRow(
                  prefixText: 'Design Type',
                  suffixText:
                      widget.categoryName[0].toUpperCase() +
                      widget.categoryName.substring(1),
                  sufixstyle: context.inter50014,
                ),
                CardRow(
                  prefixText: 'Price',
                  suffixText: formatPrice(widget.price),
                ),
                CardRow(
                  prefixText: 'Discount',
                  suffixText: formatPrice(widget.discountPrice),
                ),
                Row(
                  children: [
                    Text('Qty'),
                    Spacer(),

                    Chip(label: Text(widget.quantity.toString())),
                  ],
                ),
                CardRow(
                  prefixText: 'Total Amount',
                  suffixText: formatPrice(widget.totalPrice),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
