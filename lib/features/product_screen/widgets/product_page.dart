import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/data/product_category_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_service.dart';
import 'package:taproot_admin/features/product_screen/widgets/add_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/edit_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_detail_row.dart';
import 'package:taproot_admin/features/product_screen/widgets/search_widget.dart';
import 'package:taproot_admin/features/product_screen/widgets/sort_button.dart';
import 'package:taproot_admin/features/product_screen/widgets/view_product.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ProductPage extends StatefulWidget {
  final VoidCallback addTap;
  final VoidCallback viewTap;
  const ProductPage({super.key, required this.addTap, required this.viewTap});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  List<Map<String, Object>> products = [];
  ProductResponse? product;
  List<ProductCategory> productCategory = [];
  late TabController _tabController;
  void addProducts(Map<String, Object> product) {
    setState(() {
      products.add(product);
      enabledList.add(true);
    });
  }

  bool addProduct = false;
  List<bool> enabledList = [];

  bool viewProduct = false;
  @override
  void initState() {
    super.initState();
    fetchInitialData();

    enabledList = List.generate(products.length, (index) => true);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !_isLoadingMore &&
        _hasMoreData) {
      _isLoadingMore = true;
      _currentPage++;
      fetchProduct(page: _currentPage);
    }
  }

  Future<void> fetchInitialData() async {
    await fetchProductCategory();
    _tabController = TabController(
      length: productCategory.length + 1,
      vsync: this,
    );
    logSuccess('TabController length: ${_tabController.length}');
    logSuccess(productCategory.length + 1);

    fetchProduct();
  }

  Future<void> fetchProduct({int page = 1}) async {
    try {
      final response = await ProductService.getProduct(page: page);
      setState(() {
        if (page == 1) {
          product = response;
        } else {
          product!.results.addAll(response.results);
        }
        _hasMoreData = response.results.isNotEmpty;
        _isLoadingMore = false;
        enabledList = List.generate(product!.results.length, (index) => true);
      });
    } catch (e) {
      logError('Error fetching products: $e');
      _isLoadingMore = false;
    }
  }

  Future<void> fetchProductCategory() async {
    try {
      final response = await ProductService.getProductCategory();
      setState(() {
        productCategory = response;
      });
    } catch (e) {
      logError('Error fetching product categories: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          product == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => AddProduct(
                                      onSave: () => fetchInitialData(),
                                      onBack: () => Navigator.pop(context),
                                    ),
                              ),
                            );

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
                            controller: _tabController,
                            unselectedLabelColor: CustomColors.hintGrey,

                            unselectedLabelStyle: context.inter50016,
                            labelColor: CustomColors.textColor,
                            labelStyle: context.inter50016,
                            isScrollable: true,
                            indicatorColor: CustomColors.greenDark,
                            indicatorWeight: 4,
                            dragStartBehavior: DragStartBehavior.start,

                            tabs: [
                              const Tab(text: 'All'),
                              ...productCategory.map(
                                (category) => Tab(text: category.name ?? ''),
                              ),
                              // Tab(text: 'All'),
                              // Tab(text: 'Premium'),
                              // Tab(text: 'Basic'),
                              // Tab(text: 'Modern'),
                              // Tab(text: 'Classic'),
                              // Tab(text: 'Business'),
                            ],
                          ),
                          Gap(CustomPadding.paddingXL.v),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                GridView.builder(
                                  controller: _scrollController,
                                  itemCount: product!.results.length + 1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.8,
                                        crossAxisCount: 2,
                                        mainAxisSpacing:
                                            CustomPadding.paddingXL.v,
                                        crossAxisSpacing:
                                            CustomPadding.paddingXL.v,
                                      ),
                                  itemBuilder: (context, index) {
                                    if (index == product!.results.length) {
                                      return _isLoadingMore
                                          ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                          : SizedBox.shrink();
                                    }

                                    final productcard = product!.results[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ViewProduct(
                                                  product: productcard,
                                                  images:
                                                      productcard.productImages!
                                                          .map((e) => e.key)
                                                          .toList(),

                                                  onBack: () {
                                                    Navigator.pop(context);
                                                  },
                                                  onEdit: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => EditProduct(
                                                              product:
                                                                  productcard,
                                                              images:
                                                                  productcard
                                                                      .productImages!
                                                                      .map(
                                                                        (e) =>
                                                                            e.key,
                                                                      )
                                                                      .toList(),
                                                              // price:
                                                              //     product.actualPrice
                                                              //         .toString(),

                                                              // offerPrice:
                                                              //     product
                                                              //         .discountedPrice
                                                              //         .toString(),
                                                              // productName:
                                                              //     product.name
                                                              //         .toString(),
                                                              // cardType:
                                                              //     product.type
                                                              //         .toString(),
                                                              // description:
                                                              //     product.actualPrice
                                                              //         .toString(),
                                                              // images:
                                                              //     (product['images']
                                                              //             as List<
                                                              //               dynamic
                                                              //             >)
                                                              //         .map(
                                                              //           (e) =>
                                                              //               e.toString(),
                                                              //         )
                                                              //         .toList(),
                                                            ),
                                                      ),
                                                    );
                                                  },

                                                  //   price: product['price'].toString(),
                                                  //   offerPrice:
                                                  //       product['discountPrice']
                                                  //           .toString(),
                                                  //   productName:
                                                  //       product['templateName']
                                                  //           .toString(),
                                                  //   cardType: product['type'].toString(),
                                                  //   description:
                                                  //       product['description'].toString(),
                                                  //  images:
                                                  //       (product['images']
                                                  //               as List<dynamic>)
                                                  //           .map((e) => e.toString())
                                                  //           .toList(),
                                                ),
                                          ),
                                        );
                                        // widget.viewTap();
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
                                            color:
                                                CustomColors.textColorLightGrey,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Gap(CustomPadding.paddingLarge.v),
                                            Row(
                                              children: [
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
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
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            CustomPadding
                                                                .padding
                                                                .v,
                                                          ),
                                                      child: Image.network(
                                                        '$baseUrl/file?key=products/${productcard.productImages!.first.key}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        productcard.name
                                                            .toString(),
                                                        style:
                                                            context.inter50014,
                                                      ),
                                                      Gap(
                                                        CustomPadding
                                                            .paddingLarge
                                                            .v,
                                                      ),
                                                      ProductDetaileRow(
                                                        cardType:
                                                            productcard
                                                                .category!
                                                                .name ??
                                                            ''.toString(),
                                                        price:
                                                            productcard
                                                                .actualPrice
                                                                .toString(),
                                                        offerPrice:
                                                            productcard
                                                                .discountedPrice
                                                                .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
                                                ),
                                              ],
                                            ),
                                            Gap(CustomPadding.paddingLarge.v),
                                            Row(
                                              children: [
                                                Gap(
                                                  CustomPadding.paddingLarge.v,
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
                                                Gap(CustomPadding.padding.v),
                                                enabledList[index]
                                                    ? Text('Enable')
                                                    : Text('Disabled'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Center(child: Text('Premium')),
                                Center(child: Text('Basic')),
                                Center(child: Text('Modern')),
                                // Center(child: Text('Classic')),
                                // Center(child: Text('Business')),
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
