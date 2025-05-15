import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/view/create_order_details.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/gradient_border_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  List<UserSearch> userSearchList = [];
  bool isLoading = false;

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
                  onChanged: (value) => fetchUser(value),
                ),
                Gap(CustomPadding.paddingLarge.v),

                if (isLoading)
                  CircularProgressIndicator()
                else
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
                              // shape: ,

                              // style: ,
                              // contentPadding: EdgeInsets.all(
                              //   CustomPadding.padding.v,
                              // ),
                              // focusColor: ,
                              // hoverColor: CustomColors.green,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CreateOrderDetails(),
                                  ),
                                );
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
                GradientBorderField(hintText: 'Add Product + '),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
