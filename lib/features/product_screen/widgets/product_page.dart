import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
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
import 'package:taproot_admin/widgets/not_found_widget.dart';

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
  bool _isLoading = false;
  Timer? _searchDebounce;
  String _currentSearchQuery = '';

  List<Product> _filteredProducts = [];

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
  SortOption _currentSort = SortOption.all;
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
    if (_isLoading) return;

    try {
      if (page == 1) {
        setState(() {
          _isLoading = true;
          _isLoadingMore = false;
          _hasMoreData = true;
          _currentPage = 1;
        });
      }

      final response = await ProductService.getProduct(
        page: page,
        searchQuery: _currentSearchQuery,
        sort: _currentSort.apiParameter,
      );

      if (mounted) {
        setState(() {
          if (page == 1) {
            product = response;
            _filteredProducts = response.results;
          } else {
            product!.results.addAll(response.results);
            _filteredProducts = product!.results;
          }
          _hasMoreData = response.results.isNotEmpty;
          _isLoadingMore = false;
          enabledList = List.generate(product!.results.length, (index) => true);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoadingMore = false;
        });
      }
      logError('Error fetching products: $e');
    }
  }

  void _handleSort(SortOption sortOption) {
    setState(() {
      _currentSort = sortOption;
      _currentPage = 1;
    });
    fetchProduct(page: 1);
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

  Future<void> refreshProducts() async {
    await fetchProduct(page: 1);
  }

  // void _filterProducts(String query) {
  //   setState(() {
  //     if (query.isEmpty) {
  //       _filteredProducts = product!.results;
  //     } else {
  //       _filteredProducts =
  //           product!.results.where((product) {
  //             final name = product.name?.toLowerCase() ?? '';
  //             final category = product.category?.name?.toLowerCase() ?? '';
  //             return name.contains(query.toLowerCase()) ||
  //                 category.contains(query.toLowerCase());
  //           }).toList();
  //     }
  //   });
  // }

  void _handleSearch(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _currentSearchQuery = query;
        _currentPage = 1;
        _hasMoreData = true;
      });
      fetchProduct(page: 1);
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _tabController.dispose();
    _scrollController.dispose();

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
                              SearchWidget(
                                hintText: 'Search Template Name',

                                onChanged: _handleSearch,
                              ),
                              Spacer(),
                              SortButton(
                                currentSort: _currentSort,
                                onSortChanged: _handleSort,
                              ),
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
                                (category) => Tab(text: category.name),
                              ),
                            ],
                          ),
                          Gap(CustomPadding.paddingXL.v),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                buildProductGrid(_filteredProducts),

                                ...productCategory.map((category) {
                                  final categoryFilteredProducts =
                                      _filteredProducts
                                          .where(
                                            (product) =>
                                                product.category?.id ==
                                                category.id,
                                          )
                                          .toList();
                                  return buildProductGrid(
                                    categoryFilteredProducts,
                                  );
                                }),
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

  Widget buildProductGrid(List<Product> products) {
    if (products.isEmpty) {
      return NotFoundWidget();
    }

    return GridView.builder(
      controller: _scrollController,
      itemCount: products.length + (_hasMoreData ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2.8,
        crossAxisCount: 2,
        mainAxisSpacing: CustomPadding.paddingXL.v,
        crossAxisSpacing: CustomPadding.paddingXL.v,
      ),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return _isLoadingMore
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink();
        }

        final productcard = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(
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
                          onEdit: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditProduct(
                                      onRefreshProduct: () async {
                                        await refreshProducts();
                                      },
                                      // onRefreshProduct: refreshProducts,
                                      product: productcard,
                                    ),
                              ),
                            );
                            await refreshProducts();
                          },
                        ),
                  ),
                )
                .then((_) => refreshProducts());
          },
          child: Card(
            color: Colors.white,
            elevation: 8,
            // shadowColor: ,
            shadowColor: Colors.black.withValues(alpha: 0.6),
            // decoration: BoxDecoration(

            //   color: Colors.white,
            //   // boxShadow: floatingShadow,
            //   borderRadius: BorderRadius.circular(CustomPadding.padding * 3 ),
            //   // border: Border.all(
            //   //   width: 2,
            //   //   color: CustomColors.textColorLightGrey,
            //   // ),
            // ),
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
                          borderRadius: BorderRadius.circular(
                            CustomPadding.padding.v,
                          ),
                        ),
                        height: 170.v,
                        width: 200.v,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            CustomPadding.padding.v,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                '$baseUrl/file?key=products/${productcard.productImages!.first.key}',
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.grey),
                                ),
                            errorWidget:
                                (context, url, error) =>
                                    Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productcard.name.toString(),
                            style: context.inter50014,
                          ),
                          Gap(CustomPadding.paddingLarge.v),
                          ProductDetaileRow(
                            cardType: productcard.category!.name ?? '',
                            price: productcard.actualPrice.toString(),
                            offerPrice: productcard.salePrice.toString(),
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
                    enabledList[index] ? Text('Enable') : Text('Disabled'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget buildProductGrid(List<Product> products) {
  //   return GridView.builder(
  //     controller: _scrollController,
  //     itemCount: products.length + (_hasMoreData ? 1 : 0),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       childAspectRatio: 2.8,
  //       crossAxisCount: 2,
  //       mainAxisSpacing: CustomPadding.paddingXL.v,
  //       crossAxisSpacing: CustomPadding.paddingXL.v,
  //     ),
  //     itemBuilder: (context, index) {
  //       if (index == products.length) {
  //         return _isLoadingMore
  //             ? Center(child: CircularProgressIndicator())
  //             : SizedBox.shrink();
  //       }

  //       final productcard = products[index];
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.of(context)
  //               .push(
  //                 MaterialPageRoute(
  //                   builder:
  //                       (context) => ViewProduct(
  //                         product: productcard,
  //                         images:
  //                             productcard.productImages!
  //                                 .map((e) => e.key)
  //                                 .toList(),
  //                         onBack: () {
  //                           Navigator.pop(context);
  //                         },
  //                         onEdit: () {
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder:
  //                                   (context) => EditProduct(
  //                                     onRefreshProduct: refreshProducts,
  //                                     product: productcard,
  //                                   ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                 ),
  //               )
  //               .then((_) => refreshProducts());
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(CustomPadding.paddingLarge.v),
  //             border: Border.all(
  //               width: 2,
  //               color: CustomColors.textColorLightGrey,
  //             ),
  //           ),
  //           child: Column(
  //             children: [
  //               Gap(CustomPadding.paddingLarge.v),
  //               Row(
  //                 children: [
  //                   Gap(CustomPadding.paddingLarge.v),
  //                   Expanded(
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: CustomColors.lightGreen,
  //                         borderRadius: BorderRadius.circular(
  //                           CustomPadding.padding.v,
  //                         ),
  //                       ),
  //                       height: 170.v,
  //                       width: 200.v,
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(
  //                           CustomPadding.padding.v,
  //                         ),
  //                         child: CachedNetworkImage(
  //                           imageUrl:
  //                               '$baseUrl/file?key=products/${productcard.productImages!.first.key}',
  //                           fit: BoxFit.cover,
  //                           placeholder:
  //                               (context, url) => Shimmer.fromColors(
  //                                 baseColor: Colors.grey[300]!,
  //                                 highlightColor: Colors.grey[100]!,
  //                                 child: Container(color: Colors.grey),
  //                               ),
  //                           errorWidget:
  //                               (context, url, error) =>
  //                                   Icon(Icons.error, color: Colors.red),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Gap(CustomPadding.paddingLarge.v),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           productcard.name.toString(),
  //                           style: context.inter50014,
  //                         ),
  //                         Gap(CustomPadding.paddingLarge.v),
  //                         ProductDetaileRow(
  //                           cardType: productcard.category!.name ?? '',
  //                           price: productcard.actualPrice.toString(),
  //                           offerPrice: productcard.salePrice.toString(),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Gap(CustomPadding.paddingLarge.v),
  //                 ],
  //               ),
  //               Gap(CustomPadding.paddingLarge.v),
  //               Row(
  //                 children: [
  //                   Gap(CustomPadding.paddingLarge.v),
  //                   Switch(
  //                     value: enabledList[index],
  //                     onChanged: (value) {
  //                       setState(() {
  //                         enabledList[index] = value;
  //                       });
  //                     },
  //                   ),
  //                   Gap(CustomPadding.padding.v),
  //                   enabledList[index] ? Text('Enable') : Text('Disabled'),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
