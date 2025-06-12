import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/product_porfolio_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class PorfolioPaymentWidget extends StatelessWidget {
  const PorfolioPaymentWidget({
    super.key,
    required this.portfolioProductModel,
    required this.user,
  });

  final List<PortfolioProductModel> portfolioProductModel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLoadingButton(
          useGradient: true,
          needRow: false,
          text: 'Portfolio Payment',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                int? selectedIndex;

                return StatefulBuilder(
                  builder:
                      (context, setState) => Dialog(
                        // backgroundColor: CustomColors.secondaryColor,
                        // title: Text(
                        //   'Choose Portfolio Theme',
                        //   style: context.inter60016,
                        // ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.secondaryColor,
                            borderRadius: BorderRadius.circular(
                              CustomPadding.paddingLarge.v,
                            ),
                          ),
                          width: 600.h,
                          height: 350.h,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: CustomColors.buttonColor1,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      CustomPadding.paddingLarge,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Choose Portfolio Theme',
                                    style: context.inter60020.copyWith(
                                      color: CustomColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Gap(CustomPadding.paddingLarge.v),
                              SizedBox(
                                height: 260,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: portfolioProductModel.length,
                                  separatorBuilder:
                                      (_, __) => SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final product =
                                        portfolioProductModel[index];
                                    final isSelected = selectedIndex == index;

                                    return GestureDetector(
                                      onTap:
                                          () => setState(
                                            () => selectedIndex = index,
                                          ),
                                      child: SizedBox(
                                        width: 150,
                                        child: Card(
                                          elevation: 9,
                                          shadowColor: CustomColors.textColor,
                                          color:
                                              isSelected
                                                  ? Colors.blue.shade50
                                                  : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              CustomPadding.paddingLarge,
                                            ),
                                            side:
                                                isSelected
                                                    ? BorderSide(
                                                      color: Colors.blue,
                                                      width: 2,
                                                    )
                                                    : BorderSide.none,
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                      top: Radius.circular(
                                                        CustomPadding
                                                            .paddingLarge,
                                                      ),
                                                    ),
                                                child: Image.network(
                                                  '$baseUrlImage/products/${product.productImages.first.key}',
                                                  height: 160,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style: context.inter50014,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '₹${product.salePrice}',
                                                      style: context.inter50014
                                                          .copyWith(
                                                            color: Colors.green,
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
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Spacer(),
                              if (selectedIndex != null)
                                Row(
                                  children: [
                                    Spacer(),
                                    MiniLoadingButton(
                                      needRow: false,
                                      useGradient: true,
                                      text: 'Continue',
                                      onPressed: () {
                                        void showPaymentOptionsDialog(
                                          BuildContext context,
                                          PortfolioProductModel product,
                                        ) {
                                          String paymentMode = 'razorpay';
                                          String? offlineMethod;
                                          String? referenceId;
                                          final List<String> offlineOptions = [
                                            'Card',
                                            'UPI',
                                            'NetBanking',
                                            'Cash',
                                          ];

                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => StatefulBuilder(
                                                  builder:
                                                      (
                                                        context,
                                                        setState,
                                                      ) => Dialog(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                CustomColors
                                                                    .secondaryColor,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  CustomPadding
                                                                      .paddingLarge
                                                                      .v,
                                                                ),
                                                          ),
                                                          width: 600.h,
                                                          height: 300.h,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                height: 60,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      CustomColors
                                                                          .buttonColor1,
                                                                  borderRadius: BorderRadius.vertical(
                                                                    top: Radius.circular(
                                                                      CustomPadding
                                                                          .paddingLarge,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Spacer(),

                                                                    Center(
                                                                      child: Text(
                                                                        'Portfolio Payment - ${product.name}',
                                                                        style: context.inter60022.copyWith(
                                                                          color:
                                                                              CustomColors.secondaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Spacer(),
                                                                    IconButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                      icon: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color:
                                                                            CustomColors.secondaryColor,
                                                                      ),
                                                                    ),
                                                                    Gap(
                                                                      CustomPadding
                                                                          .paddingLarge
                                                                          .h,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Gap(
                                                                CustomPadding
                                                                    .paddingLarge
                                                                    .v,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(
                                                                  left:
                                                                      CustomPadding
                                                                          .paddingLarge,
                                                                ),
                                                                child: Text(
                                                                  'Selected Product: ₹${product.salePrice}',
                                                                ),
                                                              ),
                                                              Gap(
                                                                CustomPadding
                                                                    .padding
                                                                    .v,
                                                              ),
                                                              RadioListTile(
                                                                title: Text(
                                                                  'Razorpay',
                                                                ),
                                                                value:
                                                                    'RAZORPAY',
                                                                groupValue:
                                                                    paymentMode,
                                                                onChanged:
                                                                    (
                                                                      value,
                                                                    ) => setState(
                                                                      () =>
                                                                          paymentMode =
                                                                              value!,
                                                                    ),
                                                              ),
                                                              RadioListTile(
                                                                title: Text(
                                                                  'Offline',
                                                                ),
                                                                value:
                                                                    'OFFLINE',
                                                                groupValue:
                                                                    paymentMode,
                                                                onChanged:
                                                                    (
                                                                      value,
                                                                    ) => setState(
                                                                      () =>
                                                                          paymentMode =
                                                                              value!,
                                                                    ),
                                                              ),
                                                              if (paymentMode ==
                                                                  'OFFLINE') ...[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(
                                                                    left:
                                                                        CustomPadding
                                                                            .paddingXL,
                                                                  ),
                                                                  child: SizedBox(
                                                                    width: 300,
                                                                    child: DropdownButtonFormField<
                                                                      String
                                                                    >(
                                                                      value:
                                                                          offlineMethod,
                                                                      hint: Text(
                                                                        'Select Payment Method',
                                                                      ),
                                                                      items:
                                                                          offlineOptions
                                                                              .map(
                                                                                (
                                                                                  e,
                                                                                ) => DropdownMenuItem(
                                                                                  value:
                                                                                      e,
                                                                                  child: Text(
                                                                                    e,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                              .toList(),
                                                                      onChanged:
                                                                          (
                                                                            value,
                                                                          ) => setState(
                                                                            () =>
                                                                                offlineMethod =
                                                                                    value,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Gap(
                                                                  CustomPadding
                                                                      .paddingLarge
                                                                      .v,
                                                                ),
                                                                if (offlineMethod !=
                                                                    null)
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      left:
                                                                          CustomPadding
                                                                              .paddingXL,
                                                                    ),
                                                                    child: SizedBox(
                                                                      width:
                                                                          300,
                                                                      child: TextFormField(
                                                                        decoration: InputDecoration(
                                                                          labelText:
                                                                              'Reference ID',
                                                                        ),
                                                                        onChanged:
                                                                            (
                                                                              value,
                                                                            ) =>
                                                                                referenceId =
                                                                                    value,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                              Spacer(),
                                                              Row(
                                                                children: [
                                                                  Spacer(),
                                                                  MiniLoadingButton(
                                                                    needRow:
                                                                        false,
                                                                    useGradient:
                                                                        true,
                                                                    text:
                                                                        'Proceed',
                                                                    onPressed: () async {
                                                                      if (paymentMode ==
                                                                          'RAZORPAY') {
                                                                        await PortfolioService.createPortfolioOrder(
                                                                          userId:
                                                                              user.id,
                                                                          productId:
                                                                              product.id,
                                                                          paymentServiceProvider:
                                                                              'RAZORPAY',
                                                                          paymentMethod:
                                                                              'RAZORPAY',
                                                                        );
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text(
                                                                              'Order created via Razorpay',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else if (offlineMethod !=
                                                                          null) {
                                                                        final method =
                                                                            offlineMethod!.toUpperCase();
                                                                        final ref =
                                                                            referenceId?.trim();

                                                                        if (method !=
                                                                                'CASH' &&
                                                                            (ref ==
                                                                                    null ||
                                                                                ref.isEmpty)) {
                                                                          ScaffoldMessenger.of(
                                                                            context,
                                                                          ).showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Please enter Reference ID',
                                                                              ),
                                                                            ),
                                                                          );
                                                                          return;
                                                                        }

                                                                        await PortfolioService.createPortfolioOrder(
                                                                          userId:
                                                                              user.id,
                                                                          productId:
                                                                              product.id,
                                                                          paymentServiceProvider:
                                                                              'OFFLINE',
                                                                          paymentMethod:
                                                                              method,
                                                                          referenceId:
                                                                              ref,
                                                                        );

                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text(
                                                                              'Portfolio Purchased via $method',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text(
                                                                              'Please select an offline payment method',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                  Gap(
                                                                    CustomPadding
                                                                        .paddingLarge
                                                                        .h,
                                                                  ),
                                                                ],
                                                              ),
                                                              Gap(
                                                                CustomPadding
                                                                    .paddingLarge
                                                                    .v,
                                                              ),
                                                              //  TextButton(

                                                              //   child: Text(
                                                              //     'Proceed',
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        // title: Text(
                                                        //   'Portfolio Payment - ${product.name}',
                                                        // ),
                                                        // content: Column(
                                                        //   crossAxisAlignment:
                                                        //       CrossAxisAlignment
                                                        //           .start,
                                                        //   mainAxisSize:
                                                        //       MainAxisSize.min,
                                                        //   children: [

                                                        //   ],
                                                        // ),
                                                        // actions: [

                                                        // ],
                                                      ),
                                                ),
                                          );
                                        }

                                        Navigator.pop(context);
                                        showPaymentOptionsDialog(
                                          context,
                                          portfolioProductModel[selectedIndex!],
                                        );
                                      },
                                    ),
                                    Gap(CustomPadding.paddingLarge),
                                  ],
                                ),
                              Gap(CustomPadding.paddingLarge.v),
                            ],
                          ),
                        ),
                        // content: SizedBox(
                        //   width: 600,
                        //   height: 330,
                        //   child: Column(
                        //     children: [

                        //     ],
                        //   ),
                        // ),
                      ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
