import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ViewProduct extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onEdit;
  const ViewProduct({super.key,required this.onBack,required this.onEdit});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool isEdit =false;
  // bool viewProduct=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: Column(
                  children: [
                    Gap(CustomPadding.paddingXL.v),
                    Row(
                      children: [
                        Gap(CustomPadding.paddingXL.v),
                        GestureDetector(
                          onTap: () { 
                            widget.onBack();
                            // setState(() {
                            //   viewProduct = !viewProduct;
                            // });
                          },
                          child: Text(
                            'Product',
                            style: context.inter60016.copyWith(
                              color: CustomColors.greenDark,
                            ),
                          ),
                        ),
                        Gap(CustomPadding.padding.v),
                        Text('>', style: context.inter60016),
                        Gap(CustomPadding.padding.v),
                        Text(
                          'Modern Blue Business Card',
                          style: context.inter60016,
                        ),
                        Spacer(),
                        MiniLoadingButton(
                          icon: Icons.edit,
                          text: 'Edit',
                          onPressed: () {widget.onEdit();},
                          useGradient: true,
                          gradientColors: CustomColors.borderGradient.colors,
                        ),
                        Gap(CustomPadding.paddingLarge.v),
                        MiniGradientBorderButton(
                          text: 'Back',
                          icon: Icons.arrow_back,
                          onPressed: () {
                             widget.onBack();
                            // setState(() {
                            //   viewProduct = !viewProduct;
                            // });
                          },

                          gradient: LinearGradient(
                            colors: CustomColors.borderGradient.colors,
                          ),
                        ),
                        Gap(CustomPadding.paddingLarge.v),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingLarge.v,
                        vertical: CustomPadding.paddingLarge.v,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingLarge.v,
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.secondaryColor,
                        borderRadius: BorderRadius.circular(
                          CustomPadding.paddingLarge.v,
                        ),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductIdContainer(),
                          Gap(CustomPadding.paddingLarge.v),
                          Row(
                            children: [
                              Expanded(child: AddImageContainer()),
                              Expanded(child: AddImageContainer()),
                              Expanded(child: AddImageContainer()),
                              Expanded(child: AddImageContainer()),
                            ],
                          ),
                          Gap(CustomPadding.paddingLarge.v),
                          Container(
                            margin: EdgeInsets.only(
                              left: CustomPadding.paddingXL.v,
                            ),
                            width: SizeUtils.width / 2.5,
                            child: Column(
                              spacing: CustomPadding.paddingLarge.v,
                              children: [
                                CardRow(
                                  prefixText: 'Template Name',
                                  suffixText: 'Modern Blue Business Card',
                                ),
                                CardRow(
                                  prefixText: 'Price',
                                  suffixText: "₹149.00 / \$5.00",
                                ),
                                CardRow(
                                  prefixText: 'Discount Price',
                                  suffixText: "₹129.00 / \$4.00",
                                ),
                                CardRow(
                                  prefixText: 'Design Type',
                                  suffixText: 'Minimal',
                                ),
                                CardRow(
                                  prefixText: 'Description',
                                  suffixText: loremIpsum,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}