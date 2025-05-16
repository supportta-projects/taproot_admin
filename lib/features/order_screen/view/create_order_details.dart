import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/gradient_border_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class CreateOrderDetails extends StatefulWidget {
  final Future<void> Function(String) fetchUser;
  final List<UserSearch> userSearchList;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String whatsAppNumber;

  const CreateOrderDetails({
    super.key,
    required this.fetchUser,
    required this.email,
    required this.userSearchList,
    required this.fullName,
    required this.phoneNumber,
    required this.whatsAppNumber,
  });

  @override
  State<CreateOrderDetails> createState() => _CreateOrderDetailsState();
}

class _CreateOrderDetailsState extends State<CreateOrderDetails> {
  UserSearch? userSearchList;
  bool isLoading = false;
  bool isSearching = false;
  @override
  void initState() {
    getOrderId();
    // TODO: implement initState
    super.initState();
  }

  Future getOrderId() async {
    try {
      final response = await OrderService.getOrderId();
      logSuccess(response);
    } catch (e) {
      logError('Error fetching order ID: $e');
    }
  }

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
          CommonProductContainer(
            title: 'Order Details',
            children: [
              Gap(CustomPadding.paddingLarge.v),

              GradientBorderField(
                hintText: 'Search User name, User ID',
                onChanged: (value) async {
                  setState(() {
                    isSearching = value.isNotEmpty;
                  });
                  await widget.fetchUser(value);
                },
              ),
              Gap(CustomPadding.paddingLarge.v),
              if (isLoading)
                CircularProgressIndicator()
              else if (isSearching && widget.userSearchList.isNotEmpty)
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
                    itemCount: widget.userSearchList.length,
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
                                widget.userSearchList[index].fullName,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Phone Number- ${widget.userSearchList[index].phone}',
                                ),
                                Gap(CustomPadding.paddingLarge.v),
                                Text(
                                  'user ID-${widget.userSearchList[index].userId}',
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Gap(CustomPadding.paddingLarge.v),
                        ],
                      );
                    },
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: CustomPadding.paddingXL.v,
                      ),
                      child: Column(
                        spacing: CustomPadding.paddingLarge.v,
                        children: [
                          CardRow(prefixText: 'Order ID', suffixText: ''),
                          CardRow(
                            prefixText: 'Full Name',
                            suffixText: widget.fullName,
                          ),
                          CardRow(
                            prefixText: 'Email',
                            suffixText: widget.email,
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
                        spacing: CustomPadding.paddingLarge.v,
                        children: [
                          CardRow(
                            prefixText: 'Phone Number',
                            suffixText: widget.phoneNumber,
                          ),
                          CardRow(
                            prefixText: 'Whatsapp Number',
                            suffixText: widget.whatsAppNumber,
                          ),
                          CardRow(prefixText: '', suffixText: ''),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(CustomPadding.paddingXL.v),
            ],
          ),
        ],
      ),
    );
  }
}
