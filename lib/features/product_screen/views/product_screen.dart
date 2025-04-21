import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_detail_row.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/product_screen/widgets/sort_button.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/basic_detail_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const path = '/productScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<bool> enabledList = List.generate(6, (index) => true);
  bool addProduct = false;
  bool viewProduct = false;
  String dropdownvalue = 'Basic';
  var items = ['Premium', 'Basic', 'Modern', 'Classic', 'Business'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child:viewProduct?Scaffold(body: Center(child: Text('data'),),):
          addProduct
              ? Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(CustomPadding.paddingXL.v),
                      Row(
                        children: [
                          Gap(CustomPadding.paddingXL.v),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                addProduct = !addProduct;
                              });
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
                              setState(() {
                                addProduct = !addProduct;
                              });
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
                            Container(
                              height: 68.v,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  CustomPadding.padding.v,
                                ),
                                color: CustomColors.lightGreen,
                              ),
                              child: Row(
                                children: [
                                  Gap(CustomPadding.padding.v),
                                  Text('Product ID', style: context.inter60022),
                                ],
                              ),
                            ),
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
                                    initailValue: '',
                                    labelText: 'Template Name',
                                  ),
                                ),
                                Expanded(
                                  child: TextFormContainer(
                                    initailValue: '',
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
                                        initailValue: '',
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
                                    initailValue: '',
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
              )
              : Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(CustomPadding.paddingLarge.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MiniLoadingButton(
                            icon: Icons.add,
                            text: 'Add Product',
                            onPressed: () {
                              setState(() {
                                addProduct = !addProduct;
                              });
                            },
                            useGradient: true,
                            gradientColors: CustomColors.borderGradient.colors,
                          ),
                          Gap(CustomPadding.paddingXL.v),
                        ],
                      ),
                      Gap(CustomPadding.paddingLarge.v),
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
                        height: SizeUtils.height,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SearchWidget(),
                                Spacer(),
                                SortButton(),
                              ],
                            ),
                            Gap(CustomPadding.paddingLarge.v),
                            TabBar(
                              unselectedLabelColor: CustomColors.hintGrey,

                              unselectedLabelStyle: context.inter50016,
                              labelColor: CustomColors.textColor,
                              labelStyle: context.inter50016,
                              isScrollable: true,
                              indicatorColor: CustomColors.greenDark,
                              indicatorWeight: 4,
                              dragStartBehavior: DragStartBehavior.start,
                              tabs: [
                                Tab(text: 'All'),
                                Tab(text: 'Premium'),
                                Tab(text: 'Basic'),
                                Tab(text: 'Modern'),
                                Tab(text: 'Classic'),
                                Tab(text: 'Business'),
                              ],
                            ),
                            Gap(CustomPadding.paddingXL.v),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  GridView.builder(
                                    itemCount: 6,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 2.8,
                                          crossAxisCount: 2,
                                          mainAxisSpacing:
                                              CustomPadding.paddingXL.v,
                                          crossAxisSpacing:
                                              CustomPadding.paddingXL.v,
                                        ),
                                    itemBuilder:
                                        (context, index) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              viewProduct = !viewProduct;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    CustomPadding
                                                        .paddingLarge
                                                        .v,
                                                  ),
                                              border: Border.all(
                                                width: 2,
                                                color:
                                                    CustomColors
                                                        .textColorLightGrey,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
                                                ),
                                                Row(
                                                  children: [
                                                    Gap(
                                                      CustomPadding
                                                          .paddingLarge
                                                          .v,
                                                    ),

                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              CustomColors
                                                                  .lightGreen,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                CustomPadding
                                                                    .padding
                                                                    .v,
                                                              ),
                                                        ),
                                                        height: 170.v,
                                                        width: 200.v,
                                                      ),
                                                    ),
                                                    Gap(
                                                      CustomPadding
                                                          .paddingLarge
                                                          .v,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Modern Blue Business Card',
                                                            style:
                                                                context
                                                                    .inter50014,
                                                          ),
                                                          Gap(
                                                            CustomPadding
                                                                .paddingLarge
                                                                .v,
                                                          ),
                                                          ProductDetaileRow(
                                                            cardType: 'Minimal',
                                                            price: '1000',
                                                            offerPrice: '900',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Gap(
                                                      CustomPadding
                                                          .paddingLarge
                                                          .v,
                                                    ),
                                                  ],
                                                ),
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
                                                ),
                                                Row(
                                                  children: [
                                                    Gap(
                                                      CustomPadding
                                                          .paddingLarge
                                                          .v,
                                                    ),
                                                    Switch(
                                                      value: enabledList[index],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          enabledList[index] =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    Gap(
                                                      CustomPadding.padding.v,
                                                    ),
                                                    enabledList[index]
                                                        ? Text('Enable')
                                                        : Text('Disabled'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  ),
                                  Center(child: Text('Premium')),
                                  Center(child: Text('Basic')),
                                  Center(child: Text('Modern')),
                                  Center(child: Text('Classic')),
                                  Center(child: Text('Business')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
