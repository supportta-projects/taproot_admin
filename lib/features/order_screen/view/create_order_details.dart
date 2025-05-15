import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class CreateOrderDetails extends StatefulWidget {
  const CreateOrderDetails({super.key});

  @override
  State<CreateOrderDetails> createState() => _CreateOrderDetailsState();
}

class _CreateOrderDetailsState extends State<CreateOrderDetails> {
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
          CommonProductContainer(title: 'Order Details'),
        ],
      ),
    );
  }
}
