import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_detail_add.model.dart'
    as add_model;
import 'package:taproot_admin/features/order_screen/data/order_details_model.dart'
    as order_details;
import 'package:taproot_admin/features/order_screen/data/order_model.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/widgets/image_container_with_head.dart';
import 'package:taproot_admin/features/order_screen/widgets/image_row_container.dart';
import 'package:taproot_admin/features/order_screen/widgets/product_card.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/location_container.dart';
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
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  File? selectedImageLoco;
  File? selectedImageBanner;
  bool isUpdating = false;
  bool isEdit = true;
  Map<String, int> editedQuantities = {};
  add_model.ImageSource? newCompanyLogo;
  add_model.ImageSource? newProfilePhoto;

  order_details.OrderDetails? orderDetails;
  late Order order;
  @override
  void initState() {
    order = widget.order;
    getOrderDetails().then((_) {
      if (orderDetails != null) {
        fetchExistingData();
        initializeQuantities();
      }
    });

    super.initState();
  }

  void fetchExistingData() {
    buildingNameController.text = orderDetails!.address.address1;
    areaController.text = orderDetails!.address.address2;
    pincodeController.text = orderDetails!.address.pincode;
    stateController.text = orderDetails!.address.state;
    districtController.text = orderDetails!.address.district;
    customerNameController.text = orderDetails!.nfcDetails.customerName;
    designationController.text = orderDetails!.nfcDetails.designation;
  }

  void initializeQuantities() {
    for (var product in orderDetails!.products) {
      editedQuantities[product.product.id] = product.quantity.toInt();
    }
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

  Future<void> updateOrder() async {
    try {
      setState(() => isUpdating = true);

      final updateRequest = add_model.OrderPostModel(
        address: add_model.Address(
          name: orderDetails!.address.name,
          mobile: orderDetails!.address.mobile,
          address1: buildingNameController.text,
          address2: areaController.text,
          pincode: pincodeController.text,
          district: districtController.text,
          state: stateController.text,
          country: 'India',
        ),
        nfcDetails: add_model.NfcDetails(
          customerName: customerNameController.text,
          designation: designationController.text,
          customerLogo: add_model.ImageSource(
            image:
                newCompanyLogo?.image ??
                add_model.ImageDetails(
                  key: orderDetails!.nfcDetails.customerLogo.image.key,
                  name: orderDetails!.nfcDetails.customerLogo.image.name,
                  mimetype:
                      orderDetails!.nfcDetails.customerLogo.image.mimetype,
                  size: orderDetails!.nfcDetails.customerLogo.image.size,
                ),
            source: 'order',
          ),
          customerPhoto: add_model.ImageSource(
            image:
                newProfilePhoto?.image ??
                add_model.ImageDetails(
                  key: orderDetails!.nfcDetails.customerPhoto.image.key,
                  name: orderDetails!.nfcDetails.customerPhoto.image.name,
                  mimetype:
                      orderDetails!.nfcDetails.customerPhoto.image.mimetype,
                  size: orderDetails!.nfcDetails.customerPhoto.image.size,
                ),
            source: 'order',
          ),
        ),
        products:
            orderDetails!.products
                .map(
                  (product) => add_model.ProductQuantity(
                    product:
                        product.product is String
                            ? product.product
                            : (product.product as order_details.ProductDetails)
                                .id,
                    quantity:
                        editedQuantities[product.product is String
                            ? product.product
                            : (product.product as order_details.ProductDetails)
                                .id] ??
                        product.quantity,
                  ),
                )
                .toList(),
        totalPrice: orderDetails!.totalPrice,
      );

      final editResponse = await OrderService.editOrder(
        orderId: widget.order.id,
        data: updateRequest.toJson(),
      );

      if (editResponse.success) {
        final freshDetails = await OrderService.getOrderDetails(
          orderId: widget.order.id,
        );

        setState(() {
          orderDetails = freshDetails.result;
          orderEdit = false;
          newCompanyLogo = null;
          newProfilePhoto = null;
          isUpdating = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(editResponse.message)));
        }
      }
    } catch (e) {
      logError('Update failed: $e');
      if (mounted) {
        setState(() => isUpdating = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update order: $e')));
      }
    }
  }

  double calculateGrandTotal() {
    return orderDetails!.products.fold(0.0, (sum, product) {
      String productId =
          product.product is String
              ? product.product.toString()
              : (product.product as order_details.ProductDetails).id;

      int quantity = editedQuantities[productId] ?? product.quantity;
      return sum + (product.salePrice * quantity);
    });
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
                              onPressed: updateOrder,
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
                                            suffixText:
                                                orderDetails!.personalInfo.name,
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
                                                orderDetails?.user.email ??
                                                'N/A',
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
                                            suffixText:
                                                orderDetails!
                                                    .personalInfo
                                                    .phoneNumber,
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
                                            suffixText:
                                                orderDetails!
                                                    .personalInfo
                                                    .whatsappNumber,
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
                                            suffixText:
                                                orderDetails!.orderStatus,
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
                      grandTotal: calculateGrandTotal(),
                      // orderDetails!.totalPrice,
                      children: [
                        Column(
                          children: [
                            Gap(CustomPadding.paddingLarge.v),
                            ...List.generate(
                              orderDetails!.products.length,
                              (index) => ProductCard(
                                image:
                                    orderDetails!.products[index].product
                                            is String
                                        ? ''
                                        : (orderDetails!.products[index].product
                                                as order_details.ProductDetails)
                                            .productImages
                                            .key,
                                productName:
                                    orderDetails!.products[index].product
                                            is String
                                        ? 'Product'
                                        : (orderDetails!.products[index].product
                                                as order_details.ProductDetails)
                                            .name,
                                categoryName:
                                    orderDetails!.products[index].product
                                            is String
                                        ? ''
                                        : (orderDetails!.products[index].product
                                                as order_details.ProductDetails)
                                            .category
                                            .name,
                                orderEdit: orderEdit,
                                price: orderDetails!.products[index].salePrice,
                                discountPrice:
                                    orderDetails!.products[index].product
                                            is String
                                        ? 0
                                        : (orderDetails!.products[index].product
                                                as order_details.ProductDetails)
                                            .discountedPrice,
                                quantity:
                                    editedQuantities[orderDetails!
                                                .products[index]
                                                .product
                                            is String
                                        ? orderDetails!.products[index].product
                                            .toString()
                                        : (orderDetails!.products[index].product
                                                as order_details.ProductDetails)
                                            .id] ??
                                    orderDetails!.products[index].quantity,
                                totalPrice:
                                    orderDetails!.products[index].totalPrice,
                                onQuantityChanged:
                                    orderEdit
                                        ? (newQuantity) {
                                          setState(() {
                                            String productId =
                                                orderDetails!
                                                            .products[index]
                                                            .product
                                                        is String
                                                    ? orderDetails!
                                                        .products[index]
                                                        .product
                                                        .toString()
                                                    : (orderDetails!
                                                                .products[index]
                                                                .product
                                                            as order_details.ProductDetails)
                                                        .id;
                                            editedQuantities[productId] =
                                                newQuantity;

                                            orderDetails!
                                                .products[index] = orderDetails!
                                                .products[index]
                                                .copyWith(
                                                  quantity: newQuantity,
                                                  totalPrice:
                                                      orderDetails!
                                                          .products[index]
                                                          .salePrice *
                                                      newQuantity,
                                                );
                                          });
                                        }
                                        : null,
                              ),
                            ),
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
                          readonly: isEdit ? false : true,
                          labelText: 'Full Name',
                          initialValue: orderDetails!.nfcDetails.customerName,
                        ),
                        Gap(CustomPadding.paddingLarge.v),
                        TextFormContainer(
                          readonly: isEdit ? false : true,
                          labelText: 'Designation',
                          initialValue: orderDetails!.nfcDetails.designation,
                        ),
                        Gap(CustomPadding.paddingXL.v),

                        Row(
                          children: [
                            Gap(CustomPadding.paddingXL.v),
                            if (orderEdit)
                              ImageRowContainer(
                                userCode: orderDetails!.user.id,
                                title: 'Company Logo',
                                imageType: 'companyLogo',
                                onImageChanged: (imageSource) {
                                  setState(() => newCompanyLogo = imageSource);
                                },
                              )
                            else
                              ImageContainerWithHead(
                                heading: 'Company Logo',
                                orderDetails: orderDetails,
                                imageKey:
                                    orderDetails!
                                        .nfcDetails
                                        .customerLogo
                                        .image
                                        .key,
                              ),
                            Gap(CustomPadding.paddingXL.v),
                            if (orderEdit)
                              ImageRowContainer(
                                userCode: orderDetails!.user.id,
                                title: 'Profile Image',
                                imageType: 'profilePicture',
                                onImageChanged: (imageSource) {
                                  setState(() => newProfilePhoto = imageSource);
                                },
                              )
                            else
                              ImageContainerWithHead(
                                heading: 'Profile Image',
                                orderDetails: orderDetails,
                                imageKey:
                                    orderDetails!
                                        .nfcDetails
                                        .customerPhoto
                                        .image
                                        .key,
                              ),
                          ],
                        ),
                      ],
                    ),
                    Gap(CustomPadding.paddingXL.v),
                    orderEdit
                        ? Row(
                          children: [
                            Gap(CustomPadding.paddingLarge.v),

                            LocationContainer(
                              isEdit: true,
                              buildingNamecontroller: buildingNameController,
                              areaController: areaController,
                              districtController: districtController,
                              pincodeController: pincodeController,
                              stateController: stateController,
                            ),
                            Gap(CustomPadding.paddingLarge.v),
                          ],
                        )
                        : CommonProductContainer(
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
                                          suffixText:
                                              orderDetails!.address.pincode,
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
                                          suffixText:
                                              orderDetails!.address.state,
                                        ),
                                        CardRow(
                                          prefixText: 'Country',
                                          suffixText:
                                              orderDetails!.address.country,
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
                        ? Center(
                          child: Container(
                            child: MiniLoadingButton(
                              needRow: false,
                              text: 'Cancel Order',
                              onPressed: () {},
                              useGradient: true,
                              gradientColors:
                                  CustomColors.borderGradient.colors,
                            ),
                          ),
                        )
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
                                          suffixText:
                                              orderDetails?.razorpayPaymentId ??
                                              '',
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
