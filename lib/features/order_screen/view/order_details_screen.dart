import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/widgets/product_card.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/padding_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class OrderDetailScreen extends StatefulWidget {
  final dynamic user;
  final Order order;

  final String orderId;
  const OrderDetailScreen({
    super.key,
    required this.orderId,
    this.user,
    required this.order,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  File? selectedImageLoco;
  File? selectedImageBanner;
  bool isEdit = true;
  // var orderDetails;
  OrderDetails? orderDetails;
  late Order order;
  @override
  void initState() {
    order = widget.order;
    getOrderDetails();
    // TODO: implement initState
    super.initState();
  }

  bool orderEdit = false;
  void editOrder() {
    setState(() {
      orderEdit = !orderEdit;
      logSuccess('mmmm${order.paymentStatus}');
    });
  }

  Future<void> getOrderDetails() async {
    try {
      final response = await OrderService.getOrderDetails(
        orderId: widget.order.id,
      );
      setState(() {
        orderDetails = response.result;
      });
    } catch (e) {
      logError('Failed to fetch order details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch order details. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
    String formatDateString(String dateString) {
      try {
        DateTime dateTime = DateTime.parse(dateString);
        return dateFormatter.format(dateTime);
      } catch (e) {
        return 'Invalid date';
      }
    }

    void pickImage({required bool isLogo}) async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (isLogo) {
            selectedImageLoco = File(result.files.first.path!);
          } else {
            selectedImageBanner = File(result.files.first.path!);
          }
        });
      }
    }

    // DateTime date = DateTime(now.year, now.month, now.day);
    return Scaffold(
      body:
          orderDetails == null
              ? CircularProgressIndicator()
              : SingleChildScrollView(
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
                              gradientColors:
                                  CustomColors.borderGradient.colors,
                            ),
                        Gap(CustomPadding.paddingLarge.v),
                        orderEdit
                            ? MiniLoadingButton(
                              icon: LucideIcons.save,
                              text: 'Save',
                              onPressed: () {},
                              useGradient: true,
                              gradientColors:
                                  CustomColors.borderGradient.colors,
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
                                        horizontal:
                                            CustomPadding.paddingLarge.v,
                                      ),

                                      child: Column(
                                        spacing: CustomPadding.paddingLarge.v,
                                        children: [
                                          Gap(CustomPadding.padding.v),

                                          CardRow(
                                            prefixText: 'Full Name',
                                            suffixText: order.user.name,
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.green,
                                                ),
                                          ),
                                          CardRow(
                                            prefixText: 'Email',
                                            suffixText:
                                                orderDetails!.user.email,
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
                                                  color: CustomColors.textColor,
                                                ),
                                          ),
                                          CardRow(
                                            prefixText: 'Phone Number',
                                            suffixText: order.address.mobile,
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
                                                  color: CustomColors.textColor,
                                                ),
                                          ),
                                          CardRow(
                                            prefixText: 'WhatsApp Number',
                                            suffixText: '8976543467',
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
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
                                        horizontal:
                                            CustomPadding.paddingLarge.v,
                                      ),

                                      child: Column(
                                        spacing: CustomPadding.paddingLarge.v,
                                        children: [
                                          CardRow(
                                            prefixText: 'Order ID',
                                            suffixText: widget.orderId,
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
                                                  color: CustomColors.textColor,
                                                ),
                                          ),
                                          CardRow(
                                            prefixText: 'Order Date',
                                            suffixText: formatDateString(
                                              orderDetails!.createdAt,
                                            ),

                                            //  date
                                            //     .toString()
                                            //     .replaceAll("00:00:00.000", ""),
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
                                                  color: CustomColors.textColor,
                                                ),
                                          ),
                                          CardRow(
                                            prefixText: 'Order Status',
                                            suffixText: order.orderStatus,
                                            prefixstyle: context.inter50014
                                                .copyWith(
                                                  color: CustomColors.hintGrey,
                                                ),
                                            sufixstyle: context.inter50016
                                                .copyWith(
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
                      grandTotal: orderDetails!.totalPrice.toInt(),
                      children: [
                        Column(
                          children: [
                            Gap(CustomPadding.paddingLarge.v),
                            ...List.generate(
                              orderDetails!.products.length,
                              (index) => ProductCard(
                                orderEdit: orderEdit,
                                price:
                                    orderDetails!.products[index].actualPrice
                                        .toInt(),
                                discountPrice:
                                    orderDetails!
                                        .products[index]
                                        .discountedPrice
                                        .toInt(),
                                quantity:
                                    orderDetails!.products[index].quantity
                                        .toInt(),
                                totalPrice:
                                    orderDetails!.products[index].totalPrice
                                        .toInt(),
                              ),
                            ),

                            // ProductCard(orderEdit: orderEdit),
                            // ProductCard(orderEdit: orderEdit),
                          ],
                        ),
                      ],
                    ),
                    Gap(CustomPadding.paddingXL.v),
                    CommonProductContainer(
                      title: 'NFC Card Details',
                      children: [
                        Gap(CustomPadding.paddingLarge.v),

                        TextFormContainer(
                          readonly: true,
                          labelText: 'Full Name',
                          initialValue: orderDetails!.nfcDetails.customerName,
                        ),
                        Gap(CustomPadding.paddingLarge.v),
                        TextFormContainer(
                          readonly: true,
                          labelText: 'Designation',
                          initialValue: orderDetails!.nfcDetails.designation,
                        ),
                        Row(
                          children: [
                            isEdit
                                ? ImageContainer(
                                  selectedFile: selectedImageLoco,
                                  isEdit: true,
                                  icon:
                                      selectedImageLoco == null
                                          ? LucideIcons.upload
                                          : LucideIcons.repeat,
                                  title: 'Loco',
                                  onTap: () => pickImage(isLogo: true),
                                  imageState:
                                      selectedImageLoco == null
                                          ? 'Upload'
                                          : 'Replace',
                                )
                                : ImageContainer(
                                  onTap: () {},
                                  isEdit: false,
                                  title: 'Loco',
                                  icon: LucideIcons.upload,
                                  imageState: 'Upload',
                                  selectedFile: null,
                                ),
                            isEdit
                                ? ImageContainer(
                                  onTap: () => pickImage(isLogo: false),
                                  isEdit: true,
                                  title: 'Banner Image',
                                  icon:
                                      selectedImageBanner == null
                                          ? LucideIcons.upload
                                          : LucideIcons.repeat,
                                  imageState:
                                      selectedImageBanner == null
                                          ? 'Upload'
                                          : 'Replace',
                                  selectedFile: selectedImageBanner,
                                )
                                : ImageContainer(
                                  onTap: () {},
                                  icon: LucideIcons.upload,
                                  title: 'Banner Image',
                                  imageState: 'Upload',
                                  selectedFile: null,
                                  
                                ),
                          ],
                        ),
                      ],
                    ),
                    Gap(CustomPadding.paddingXL.v),
                    CommonProductContainer(
                      title: 'Shipping Address',
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: CustomPadding.paddingLarge.v,
                                ),
                                child: Column(
                                  spacing: CustomPadding.paddingLarge.v,
                                  children: [
                                    Gap(CustomPadding.padding.v),

                                    CardRow(
                                      prefixText: 'Building Name',
                                      suffixText:
                                          orderDetails!.address.address1,
                                    ),
                                    CardRow(
                                      prefixText: 'Area',
                                      suffixText:
                                          orderDetails!.address.address2,
                                    ),
                                    CardRow(
                                      prefixText: 'PinCode',
                                      suffixText: orderDetails!.address.pincode,
                                    ),
                                    Gap(CustomPadding.padding.v),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: CustomPadding.paddingLarge.v,
                                ),
                                child: Column(
                                  spacing: CustomPadding.paddingLarge.v,
                                  children: [
                                    Gap(CustomPadding.padding.v),

                                    CardRow(
                                      prefixText: 'District',
                                      suffixText:
                                          orderDetails!.address.district,
                                    ),
                                    CardRow(
                                      prefixText: 'State',
                                      suffixText: orderDetails!.address.state,
                                    ),
                                    CardRow(
                                      prefixText: 'Country',
                                      suffixText: orderDetails!.address.country,
                                    ),
                                    Gap(CustomPadding.padding.v),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                                          suffixText:
                                              orderDetails!.paymentStatus,
                                          sufixstyle: context.inter50016
                                              .copyWith(
                                                color: CustomColors.green,
                                              ),
                                        ),
                                        CardRow(
                                          prefixText: 'Payment Method',
                                          suffixText: orderDetails!.paymentMode,
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
                                          suffixText:
                                              ' ₹ ${orderDetails!.totalPrice}',
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
