import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.orderEdit, required this.discountPrice,required this.price, required this.quantity, required this.totalPrice});
final int price;
final int discountPrice;
  final bool orderEdit;
  
  final int quantity;
  
  final int totalPrice;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
                Text('Modern Blue Business Card', style: context.inter60020),
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
                CardRow(prefixText: 'Design Type', suffixText: 'Minimal'),
                CardRow(prefixText: 'Price', suffixText: widget.price.toString()),
                CardRow(prefixText: 'Discount', suffixText: widget.discountPrice.toString()),
                Row(
                  children: [
                    Text('Qty'),
                    Spacer(),

                    Chip(label: Text(widget.quantity.toString())),
                  ],
                ),
                CardRow(
                  prefixText: 'Total Amount',
                  suffixText: widget.totalPrice.toString(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
