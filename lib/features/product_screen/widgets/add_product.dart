import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddProduct extends StatefulWidget {
  final VoidCallback onBack;
  const AddProduct({super.key,required this.onBack});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  // bool addProduct = false;
  String dropdownvalue = 'Basic';
  var items = ['Premium', 'Basic', 'Modern', 'Classic', 'Business'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(CustomPadding.paddingXL.v),
                      Row(
                        children: [
                          Gap(CustomPadding.paddingXL.v),

                          GestureDetector(
                            onTap: () {
                              widget.onBack();
                              // setState(() {
                              //   addProduct = !addProduct;
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
                          Text('Add Product', style: context.inter60016),
                          Spacer(),

                          MiniGradientBorderButton(
                            text: 'Back',
                            icon: Icons.arrow_back,
                            onPressed: () {
                              widget.onBack();
                              // setState(() {
                              //   addProduct = !addProduct;
                              // });
                            },

                            gradient: LinearGradient(
                              colors: CustomColors.borderGradient.colors,
                            ),
                          ),
                          Gap(CustomPadding.paddingLarge.v),
                          MiniLoadingButton(
                            icon: LucideIcons.save,
                            text: 'Save',
                            onPressed: () {},
                            useGradient: true,
                            gradientColors: CustomColors.borderGradient.colors,
                          ),
                          Gap(CustomPadding.paddingXL.v),
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
                            Gap(CustomPadding.paddingXL.v),
                            Row(children: [AddImageContainer()]),
                            Gap(CustomPadding.paddingLarge.v),
                            Text(
                              'You can Choose Maximum of 4 Photos. JPG, GIF or PNG. Max size of 800K',
                              style: TextStyle(color: CustomColors.hintGrey),
                            ),
                            Gap(CustomPadding.paddingLarge.v),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormContainer(
                                    initialValue: '',
                                    labelText: 'Template Name',
                                  ),
                                ),
                                Expanded(
                                  child: TextFormContainer(
                                    initialValue: '',
                                    labelText: 'Discount',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextFormContainer(
                                        initialValue: '',
                                        labelText: 'Price',
                                      ),
                                      Row(
                                        children: [
                                          Gap(CustomPadding.paddingLarge.v),
                                          Text('Design Type'),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    CustomPadding
                                                        .paddingLarge
                                                        .v,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    CustomPadding
                                                        .paddingLarge
                                                        .v,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      CustomPadding
                                                          .paddingSmall
                                                          .v,
                                                    ),
                                                border: Border.all(
                                                  color:
                                                      CustomColors
                                                          .textColorLightGrey,
                                                ),
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  underline: null,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                  ),
                                                  isExpanded: true,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        CustomPadding.padding.v,
                                                      ),
                                                  value: dropdownvalue,
                                                  items:
                                                      items.map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                  onChanged: (
                                                    String? newValue,
                                                  ) {
                                                    setState(() {
                                                      dropdownvalue = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TextFormContainer(
                                    maxline: 4,
                                    initialValue: '',
                                    labelText: 'Description',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}