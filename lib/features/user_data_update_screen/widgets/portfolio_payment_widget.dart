import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/product_porfolio_model.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
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
                      (context, setState) => AlertDialog(
                        backgroundColor: CustomColors.secondaryColor,
                        title: Text(
                          'Choose Portfolio Theme',
                          style: context.inter60016,
                        ),
                        content: SizedBox(
                          width: 600,
                          height: 330,
                          child: Column(
                            children: [
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
                              if (selectedIndex != null)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
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
                                                    ) => AlertDialog(
                                                      title: Text(
                                                        'Portfolio Payment - ${product.name}',
                                                      ),
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Selected Product: ₹${product.salePrice}',
                                                          ),
                                                          Gap(16),
                                                          RadioListTile(
                                                            title: Text(
                                                              'Razorpay',
                                                            ),
                                                            value: 'RAZORPAY',
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
                                                            value: 'OFFLINE',
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
                                                            SizedBox(
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
                                                            Gap(
                                                              CustomPadding
                                                                  .paddingLarge
                                                                  .v,
                                                            ),
                                                            if (offlineMethod !=
                                                                null)
                                                              SizedBox(
                                                                width: 300,
                                                                child: TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                        labelText:
                                                                            'Reference ID',
                                                                      ),
                                                                  onChanged:
                                                                      (value) =>
                                                                          referenceId =
                                                                              value,
                                                                ),
                                                              ),
                                                          ],
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            if (paymentMode ==
                                                                'RAZORPAY') {
                                                              await PortfolioService.createPortfolioOrder(
                                                                userId: user.id,
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
                                                                  offlineMethod!
                                                                      .toUpperCase();
                                                              final ref =
                                                                  referenceId
                                                                      ?.trim();

                                                              if (method !=
                                                                      'CASH' &&
                                                                  (ref == null ||
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
                                                                userId: user.id,
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

                                                          child: Text(
                                                            'Proceed',
                                                          ),
                                                        ),
                                                      ],
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
                                    child: Text('Continue to Payment'),
                                  ),
                                ),
                            ],
                          ),
                        ),
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
