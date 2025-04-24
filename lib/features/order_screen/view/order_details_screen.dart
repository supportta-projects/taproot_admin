import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/widgets/product_card.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class OrderDetailScreen extends StatefulWidget {
  final dynamic user;

  final String orderId;
  const OrderDetailScreen({
    super.key,
    required this.orderId,
    required this.user,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late User user;
  @override
  void initState() {
    user = widget.user;
    // TODO: implement initState
    super.initState();
  }

  bool orderEdit = false;
  void editOrder() {
    setState(() {
      orderEdit = !orderEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
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
                orderEdit
                    ? MiniGradientBorderButton(
                      text: 'Cancel',
                      onPressed: () {
                        editOrder();
                      },

                      gradient: LinearGradient(
                        colors: CustomColors.borderGradient.colors,
                      ),
                    )
                    : MiniLoadingButton(
                      icon: Icons.edit,
                      text: 'Edit',
                      onPressed: () {
                        editOrder();
                      },
                      useGradient: true,
                      gradientColors: CustomColors.borderGradient.colors,
                    ),
                Gap(CustomPadding.paddingLarge.v),
                orderEdit
                    ? MiniLoadingButton(
                      icon: LucideIcons.save,
                      text: 'Save',
                      onPressed: () {},
                      useGradient: true,
                      gradientColors: CustomColors.borderGradient.colors,
                    )
                    : MiniGradientBorderButton(
                      text: 'Back',
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      gradient: LinearGradient(
                        colors: CustomColors.borderGradient.colors,
                      ),
                    ),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),

            Gap(CustomPadding.paddingLarge.v),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  CommonUserContainer(
                    height: 260.v,
                    title: 'Order Details',
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: CustomPadding.paddingLarge.v,
                              ),

                              child: Column(
                                spacing: CustomPadding.paddingLarge.v,
                                children: [
                                  Gap(CustomPadding.padding.v),

                                  CardRow(
                                    prefixText: 'Full Name',
                                    suffixText: 'Santhosh',
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50014.copyWith(
                                      color: CustomColors.green,
                                    ),
                                  ),
                                  CardRow(
                                    prefixText: 'Email',
                                    suffixText: 'santhosh@gmail.com',
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                  CardRow(
                                    prefixText: 'Phone Number',
                                    suffixText: '8976543467',
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                  CardRow(
                                    prefixText: 'WhatsApp Number',
                                    suffixText: '8976543467',
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: CustomPadding.paddingLarge.v,
                              ),

                              child: Column(
                                spacing: CustomPadding.paddingLarge.v,
                                children: [
                                  CardRow(
                                    prefixText: 'Order ID',
                                    suffixText: widget.orderId,
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                  CardRow(
                                    prefixText: 'Order Date',
                                    suffixText: date.toString().replaceAll(
                                      "00:00:00.000",
                                      "",
                                    ),
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                  CardRow(
                                    prefixText: 'Order Status',
                                    suffixText: 'Pending',
                                    prefixstyle: context.inter50014.copyWith(
                                      color: CustomColors.hintGrey,
                                    ),
                                    sufixstyle: context.inter50016.copyWith(
                                      color: CustomColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            CommonProductContainer(
              isAmountContainer: true,
              title: 'Product Summary',
              children: [
                Column(
                  children: [
                    Gap(CustomPadding.paddingLarge.v),

                    ProductCard(orderEdit: orderEdit),
                    ProductCard(orderEdit: orderEdit),
                  ],
                ),
              ],
            ),
            Gap(CustomPadding.paddingXL.v),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [LocationContainer(user: user, isEdit: orderEdit)],
              ),
            ),
            Gap(CustomPadding.paddingXL.v),
            orderEdit
                ? SizedBox()
                : CommonProductContainer(
                  title: 'Payment Details',
                  children: [
                    Gap(CustomPadding.paddingLarge.v),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: CustomPadding.paddingLarge.v,
                            ),
                            child: Column(
                              spacing: CustomPadding.paddingLarge,
                              children: [
                                CardRow(
                                  prefixText: 'Payment Status',
                                  suffixText: 'Paid',
                                  sufixstyle: context.inter50016.copyWith(
                                    color: CustomColors.green,
                                  ),
                                ),
                                CardRow(
                                  prefixText: 'Payment Method',
                                  suffixText: 'Prepaid',
                                  sufixstyle: context.inter50016,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: CustomPadding.paddingLarge.v,
                            ),
                            child: Column(
                              spacing: CustomPadding.paddingLarge,
                              children: [
                                CardRow(
                                  prefixText: 'Transaction ID',
                                  suffixText: '#123456789',
                                  sufixstyle: context.inter50016,
                                ),
                                CardRow(
                                  prefixText: 'Total Amount',
                                  suffixText: '₹ 12000',
                                  sufixstyle: context.inter50016,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                  ],
                ),
            Gap(CustomPadding.paddingXXL.v),
          ],
        ),
      ),
    );
  }
}
