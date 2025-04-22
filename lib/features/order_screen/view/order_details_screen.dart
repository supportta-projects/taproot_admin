import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

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
              MiniLoadingButton(
                icon: Icons.edit,
                text: 'Edit',
                onPressed: () {},
                useGradient: true,
                gradientColors: CustomColors.borderGradient.colors,
              ),
              Gap(CustomPadding.paddingLarge.v),
              MiniGradientBorderButton(
                text: 'Back',
                icon: Icons.arrow_back,
                onPressed: () {},

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
                  title: 'Order Details',
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingXL.v,
                      ),
                      child: Column(
                        children: [
                          CardRow(prefixText: 'Order ID', suffixText: orderId),
                          CardRow(
                            prefixText: 'Full Name',
                            suffixText: 'Santhosh Kumar',
                          ),
                          CardRow(prefixText: 'Email', suffixText: '327492'),
                          CardRow(
                            prefixText: 'Phone Number',
                            suffixText: '327492',
                          ),
                          CardRow(
                            prefixText: 'WhatsApp Number',
                            suffixText: '327492',
                          ),
                          CardRow(
                            prefixText: 'Order Date',
                            suffixText: '327492',
                          ),
                        ],
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
