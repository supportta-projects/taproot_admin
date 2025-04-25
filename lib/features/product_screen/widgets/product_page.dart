import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/add_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_detail_row.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/product_screen/widgets/sort_button.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ProductPage extends StatefulWidget {
  final VoidCallback addTap;
  final VoidCallback viewTap;
  const ProductPage({super.key, required this.addTap, required this.viewTap});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, String>> products = [];
  void addProducts(Map<String, String> product) {
    setState(() {
      products.add(product);
    });
  }

  bool addProduct = false;
  List<bool> enabledList = List.generate(6, (index) => true);

  bool viewProduct = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () async {
                    final addProduct = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => AddProduct(
                              onBack: () => Navigator.pop(context),
                            ),
                      ),
                    );
                    if (addProduct != null) {
                      addProducts(addProduct);
                    }
                    // widget.addTap();
                    // setState(() {
                    //   addProduct = !addProduct;
                    // });
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
                      SearchWidget(hintText: 'Search Template Name'),
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
                          // final product=products[index];
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2.8,
                                crossAxisCount: 2,
                                mainAxisSpacing: CustomPadding.paddingXL.v,
                                crossAxisSpacing: CustomPadding.paddingXL.v,
                              ),
                              
                          itemBuilder:
                              (context, index) => GestureDetector(
                                onTap: () {
                                  widget.viewTap();
                                  // setState(() {
                                  //   viewProduct = !viewProduct;
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      CustomPadding.paddingLarge.v,
                                    ),
                                    border: Border.all(
                                      width: 2,
                                      color: CustomColors.textColorLightGrey,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Gap(CustomPadding.paddingLarge.v),
                                      Row(
                                        children: [
                                          Gap(CustomPadding.paddingLarge.v),

                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: CustomColors.lightGreen,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      CustomPadding.padding.v,
                                                    ),
                                              ),
                                              height: 170.v,
                                              width: 200.v,
                                              child: Center(
                                                child: Text('image here'),
                                              ),
                                            ),
                                          ),
                                          Gap(CustomPadding.paddingLarge.v),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  products[index]['templateName'] ??
                                                      'No Name',
                                                  // 'Modern Blue Business Card',
                                                  style: context.inter50014,
                                                ),
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
                                                ),
                                                ProductDetaileRow(
                                                  cardType: 'Minimal',
                                                  price: products[index]['price'] ??
                                                      'No Price',
                                                  offerPrice: products[index]['discountPrice'] ??
                                                      'No offer',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(CustomPadding.paddingLarge.v),
                                        ],
                                      ),
                                      Gap(CustomPadding.paddingLarge.v),
                                      Row(
                                        children: [
                                          Gap(CustomPadding.paddingLarge.v),
                                          Switch(
                                            value: enabledList[index],
                                            onChanged: (value) {
                                              setState(() {
                                                enabledList[index] = value;
                                              });
                                            },
                                          ),
                                          Gap(CustomPadding.padding.v),
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
    );
  }
}
