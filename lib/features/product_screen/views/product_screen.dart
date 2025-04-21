import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const path = '/productScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(CustomPadding.paddingLarge.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MiniLoadingButton(
                icon: Icons.add,
                text: 'Add Product',
                onPressed: () {},
                useGradient: true,
                gradientColors: CustomColors.borderGradient.colors,
              ),
              Gap(CustomPadding.paddingXL.v),
            ],
          ),
          Gap(CustomPadding.paddingLarge.v),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: CustomPadding.paddingLarge.v,
            ),
            decoration: BoxDecoration(
              color: CustomColors.secondaryColor,
              borderRadius: BorderRadius.circular(CustomPadding.paddingLarge.v),
            ),
            width: double.infinity,
            height: 500,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: SizeUtils.width / 3.h,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search Template Name',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
