import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/view/create_order_details.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/gradient_border_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class CreateOrder extends StatefulWidget {
  final RefreshOrdersCallback? refreshOrders;
  const CreateOrder({super.key, this.refreshOrders});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  void initState() {
    super.initState();
    fetchUser('');
  }

  List<UserSearch> userSearchList = [];
  List<ProductSearch> productSearchList = [];
  bool isLoading = false;
  bool isSearching = false;
  bool isLoadingProduct = false;
  bool isSearchingProduct = false;

  Future<void> fetchUser(String searchQuery) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await OrderService.fetchUser(searchQuery);
      logSuccess("Fetched ${response.userSearchList.length} users");
      setState(() {
        userSearchList = response.userSearchList;
        isLoading = false;
      });
    } catch (e) {
      logError('Error fetching user: $e');
    }
  }

  Future<void> fetchProducts(String searchQuery) async {
    try {
      setState(() {
        isLoadingProduct = true;
      });
      final response = await OrderService.fetchProduct(searchQuery);
      setState(() {
        productSearchList = response.productSearch;
        isLoadingProduct = false;
      });
    } catch (e) {
      logError('Error searching product: $e');
    }
  }

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
                  onTap: () {},
                  child: Text(
                    'Order',
                    style: context.inter60016.copyWith(
                      color: CustomColors.greenDark,
                    ),
                  ),
                ),
                Gap(CustomPadding.padding.v),
                Text(
                  '>',
                  style: context.inter60016.copyWith(
                    color: CustomColors.hintGrey,
                  ),
                ),
                Gap(CustomPadding.padding.v),
                Text(
                  'Order ID',
                  style: context.inter60016.copyWith(
                    color: CustomColors.hintGrey,
                  ),
                ),
                Spacer(),
                MiniGradientBorderButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
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
                  useGradient: false,
                  backgroundColor: CustomColors.hintGrey,
                ),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),
            Gap(CustomPadding.paddingLarge.v),

            CommonProductContainer(
              title: 'Order Details',
              children: [
                Gap(CustomPadding.paddingLarge.v),

                GradientBorderField(
                  hintText: 'Search User name, User ID',
                  onChanged: (value) {
                    fetchUser(value);
                    setState(() {
                      isSearching = value.isNotEmpty;
                    });
                  },
                ),
                Gap(CustomPadding.paddingLarge.v),

                if (isLoading)
                  CircularProgressIndicator()
                else if (isSearching && userSearchList.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: CustomPadding.paddingLarge,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        CustomPadding.padding.v,
                      ),
                      border: Border.all(color: CustomColors.hintGrey),
                    ),
                    height: 300,
                    child: ListView.builder(
                      itemCount: userSearchList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () async {
                                try {
                                  final hasPortfolio =
                                      await OrderService.checkPortfolio(
                                        userid:
                                            userSearchList[index].userIdCode,
                                      );

                                  if (hasPortfolio) {
                                    if (context.mounted) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CreateOrderDetails(
                                              refreshOrders:
                                                  widget.refreshOrders,
                                              userIdCode:
                                                  userSearchList[index]
                                                      .userIdCode,
                                              userId:
                                                  userSearchList[index].userId,
                                              email:
                                                  userSearchList[index].email,
                                              phoneNumber:
                                                  userSearchList[index].phone,
                                              whatsAppNumber:
                                                  userSearchList[index].phone,
                                              fullName:
                                                  userSearchList[index]
                                                      .fullName,
                                              fetchUser: fetchUser,
                                              userSearchList: userSearchList,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Portfolio Required',
                                              style: context.inter60016,
                                            ),
                                            content: Text(
                                              'This user needs to create a portfolio before an order can be created',
                                              style: context.inter50014,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: context.inter50014
                                                      .copyWith(
                                                        color:
                                                            CustomColors
                                                                .greenDark,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Unable to check user portfolio. Please try again.',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              title: Padding(
                                padding: EdgeInsets.only(
                                  bottom: CustomPadding.paddingLarge.v,
                                ),
                                child: Text(userSearchList[index].fullName),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Phone Number- ${userSearchList[index].phone}',
                                  ),
                                  Gap(CustomPadding.paddingLarge.v),
                                  Text(
                                    'user ID-${userSearchList[index].userId}',
                                  ),
                                ],
                              ),
                            ),

                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
            Gap(CustomPadding.paddingXL.v),
            CommonProductContainer(
              title: 'Choose Product',
              children: [
                Gap(CustomPadding.paddingLarge.v),
                GradientBorderField(
                  hintText: 'Add Product + ',
                  onChanged: (value) {
                    fetchProducts(value);
                    setState(() {
                      isSearchingProduct = value.isNotEmpty;
                    });
                  },
                ),
                if (isLoadingProduct)
                  CircularProgressIndicator()
                else if (isSearchingProduct && productSearchList.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: CustomPadding.paddingLarge,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        CustomPadding.padding.v,
                      ),
                      border: Border.all(color: CustomColors.hintGrey),
                    ),
                    height: 300,
                    child: ListView.builder(
                      itemCount: productSearchList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              title: Padding(
                                padding: EdgeInsets.only(
                                  bottom: CustomPadding.paddingLarge.v,
                                ),
                                child: Text(
                                  productSearchList[index].name.toString(),
                                ),
                              ),
                              trailing: Column(
                                children: [
                                  Text(
                                    ' ₹${productSearchList[index].salePrice.toString()}',
                                    style: context.inter50014,
                                  ),
                                  Text('Price'),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
