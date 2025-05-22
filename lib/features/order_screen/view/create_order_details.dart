import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/core/api/error_exception_handler.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/widgets/image_row_container.dart';
import 'package:taproot_admin/features/order_screen/widgets/product_card.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_user_location.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/image_pick_upload_preview.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/padding_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
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
  final String userId;
  final String userIdCode;

  const CreateOrderDetails({
    super.key,
    required this.fetchUser,
    required this.email,
    required this.userSearchList,
    required this.fullName,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.userId,
    required this.userIdCode,
  });

  @override
  State<CreateOrderDetails> createState() => _CreateOrderDetailsState();
}

class _CreateOrderDetailsState extends State<CreateOrderDetails> {
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  UserSearch? userSearchList;
  List<ProductSearch> productSearchList = [];
  List<ProductSearch> selectedProducts = [];
  Map<String?, int> productQuantities = {};

  String? orderId;
  bool shouldRebuildImageWidget = false;
  bool isLoading = false;
  bool isSearching = false;
  bool isLoadingProduct = false;
  bool isSearchingProduct = false;
  PickedImage? pickedImage;
  Uint8List? companyLogoPreviewBytes;
  String? companyLogoImageUrl;
  String companyLogoUploadState = 'Upload';

  Uint8List? profileImagePreviewBytes;
  String? profileImageImageUrl;
  String profileImageUploadState = 'Upload';

  bool isUploading = false;
  PortfolioDataModel? portfolio;
  Map<String, String> labelImageMap = {'company logo': ''};

  void removeImage({required bool isCompanyLogo}) {
    setState(() {
      if (isCompanyLogo) {
        companyLogoPreviewBytes = null;
        companyLogoImageUrl = null;

        companyLogoUploadState = 'Upload';
      } else {
        profileImagePreviewBytes = null;
        profileImageImageUrl = null;
        profileImageUploadState = 'Upload';
      }
      shouldRebuildImageWidget = true;
    });
  }

  // void _pickAndUploadImage({required bool isCompanyLogo}) async {
  //   final picked = await ImagePickerService.pickImage();
  //   if (picked != null) {
  //     setState(() {
  //       if (isCompanyLogo) {
  //         companyLogoPreviewBytes = picked.bytes;

  //         companyLogoUploadState = 'Replace';
  //       } else {
  //         profileImagePreviewBytes = picked.bytes;
  //         profileImageUploadState = 'Replace';
  //       }
  //     });

  //     final uploaded = await ImagePickerService.uploadImageFile(
  //       picked.bytes,
  //       picked.filename,
  //     );
  //     setState(() {
  //       if (isCompanyLogo) {
  //         companyLogoImageUrl = uploaded.url;
  //         companyLogoUploadState = 'Uploaded';
  //       } else {
  //         profileImageImageUrl = uploaded.url;
  //         profileImageUploadState = 'Uploaded';
  //       }
  //     });
  //   }
  // }

  @override
  void initState() {
    getOrderId();
    fetchPortfolio().then((value) => fetchPortfoliData());

    super.initState();
  }

  void fetchPortfoliData() {
    designationController.text = portfolio?.workInfo.designation ?? '';
    buildingController.text = portfolio?.addressInfo.buildingName ?? '';
    areaController.text = portfolio?.addressInfo.area ?? '';
    stateController.text = portfolio?.addressInfo.state ?? '';
    pincodeController.text = portfolio?.addressInfo.pincode ?? '';
    districtController.text = portfolio?.addressInfo.district ?? '';
    fullNameController.text = portfolio?.personalInfo.name ?? '';
  }

  Future<void> getOrderId() async {
    try {
      setState(() => isLoading = true);
      final result = await OrderService.getOrderId();
      setState(() {
        orderId = result;
        isLoading = false;
      });
      logSuccess("Order ID: $orderId");
    } catch (e) {
      setState(() => isLoading = false);
      logError('Error fetching order ID: $e');
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
      setState(() {
        isLoadingProduct = false;
      });
      logError('Error searching product: $e');
    }
  }

  void onProductSelect(ProductSearch product) {
    setState(() {
      if (!selectedProducts.contains(product)) {
        selectedProducts.add(product);
        productQuantities[product.id] = 1;
      }
    });
  }

  void updateQuantity(String? productId, int newQuantity) {
    if (newQuantity > 0) {
      setState(() {
        productQuantities[productId] = newQuantity;
      });
    }
  }

  void removeProduct(ProductSearch product) {
    setState(() {
      selectedProducts.remove(product);
      productQuantities.remove(product.id);
    });
  }

  double calculateProductTotal(ProductSearch product) {
    int quantity = productQuantities[product.id] ?? 1;
    return (product.salePrice ?? 0) * quantity;
  }

  double get grandTotal {
    return selectedProducts.fold(0.0, (sum, product) {
      return sum + calculateProductTotal(product);
    });
  }

  Future fetchPortfolio() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await PortfolioService.getPortfolio(
        userid: widget.userIdCode,
      );

      if (result != null) {
        setState(() {
          portfolio = result;
          // Update states based on existing images
          if (portfolio?.workInfo.companyLogo?.key != null) {
            companyLogoUploadState = 'Replace';
          }
          if (portfolio?.personalInfo.profilePicture?.key != null) {
            profileImageUploadState = 'Replace';
          }
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        if (e is CustomException && e.statusCode == 404) {
          // Navigate to add user portfolio screen

          // Navigator.pushReplacementNamed(
          //   context,
          //   '/addUserPortfolio',
          //   arguments: user,
          // );
        } else {
          logError(e.toString());
          // You can show a Snackbar or AlertDialog to inform the user
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
        }
      }
    }
  }

  String? getPortfolioImageUrl(String? key) {
    if (key == null) return null;
    return '$baseUrl/file?key=portfolios/$key';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(CustomPadding.paddingXL.v),
            // Header Row
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
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (orderId != null)
                  Text(
                    orderId!,
                    style: context.inter60016.copyWith(
                      color: CustomColors.hintGrey,
                    ),
                  )
                else
                  Text(
                    'No Order ID',
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
            // Order Details Container
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
                          children: [
                            CardRow(
                              prefixText: 'Order ID',
                              suffixText: '$orderId',
                            ),
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
                // Product Selection Container
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
                                  onTap: () {
                                    onProductSelect(productSearchList[index]);
                                  },
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: CustomPadding.paddingLarge.v,
                                    ),
                                    child: Text(
                                      productSearchList[index].name ?? '',
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹${productSearchList[index].salePrice?.toString() ?? "0"}',
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

                // Product Summary Container
                if (selectedProducts.isNotEmpty)
                  CommonProductContainer(
                    isOrderDetails: true,
                    isAmountContainer: true,
                    title: '',
                    grandTotal: grandTotal,
                    children: [
                      Column(
                        children: [
                          Gap(CustomPadding.paddingLarge.v),
                          ...List.generate(
                            selectedProducts.length,
                            (index) => ProductCard(
                              image:
                                  selectedProducts[index]
                                      .productImages
                                      ?.first
                                      .key ??
                                  '',
                              productName: selectedProducts[index].name ?? '',
                              categoryName:
                                  selectedProducts[index].category?.name ?? '',
                              orderEdit: true,
                              price: selectedProducts[index].salePrice ?? 0,
                              discountPrice:
                                  selectedProducts[index].discountedPrice ?? 0,
                              quantity:
                                  productQuantities[selectedProducts[index]
                                      .id] ??
                                  1,
                              totalPrice: calculateProductTotal(
                                selectedProducts[index],
                              ),
                              onDelete:
                                  () => removeProduct(selectedProducts[index]),
                              onQuantityChanged:
                                  (newQuantity) => updateQuantity(
                                    selectedProducts[index].id,
                                    newQuantity,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            Gap(CustomPadding.paddingXXL.v),
            CommonProductContainer(
              title: 'NFC Card Details',
              children: [
                Gap(CustomPadding.paddingLarge.v),

                TextFormContainer(
                  labelText: 'Full Name',
                  controller: fullNameController,
                ),
                Gap(CustomPadding.paddingLarge.v),
                TextFormContainer(
                  labelText: 'Designation',
                  controller: designationController,
                ),
                Gap(CustomPadding.paddingXL.v),

                Row(
                  children: [
                    Gap(CustomPadding.paddingXL.v),
                    ImageRowContainer(
                      userCode: widget.userIdCode,
                      title: 'Company Logo',
                    ),

                    //                     Builder(
                    //                       builder: (context) {

                    // if(shouldRebuildImageWidget){
                    // return ImageContainer(onTap: () {

                    // }, icon: LucideIcons.upload, title: "Company Logo", imageState: 'Upload', onTapRemove: (){});
                    // }

                    // else

                    //                       {  return ImageContainer(
                    //                           onTapRemove: () => removeImage(isCompanyLogo: true),
                    //                           title: 'Company Logo',
                    //                           icon:
                    //                               portfolio?.workInfo.companyLogo?.key != null ||
                    //                                       companyLogoImageUrl != null
                    //                                   ? LucideIcons.repeat
                    //                                   : LucideIcons.upload,
                    //                           imageState: companyLogoUploadState,
                    //                           isEdit: true,
                    //                           onTap: () => _pickAndUploadImage(isCompanyLogo: true),
                    //                           previewBytes: companyLogoPreviewBytes,
                    //                           // imageUrl: companyLogoImageUrl,
                    //                           imageUrl:
                    //                               companyLogoImageUrl ??
                    //                               getPortfolioImageUrl(

                    //                                 portfolio?.workInfo.companyLogo?.key,
                    //                               ),
                    //                           // (portfolio?.workInfo.companyLogo?.key != null
                    //                           //     ? '$baseUrl/file?key=portfolios/${portfolio?.workInfo.companyLogo?.key}'
                    //                           //     : null),
                    //                         );}
                    //                       }
                    //                     ),
                    //                     Gap(CustomPadding.paddingXL.v),

                    //                     ImageContainer(
                    //                       onTapRemove: () => removeImage(isCompanyLogo: false),
                    //                       title: 'Profile Image',
                    //                       icon:
                    //                           portfolio?.personalInfo.profilePicture?.key != null ||
                    //                                   companyLogoImageUrl != null
                    //                               ? LucideIcons.repeat
                    //                               : LucideIcons.upload,
                    //                       imageState: profileImageUploadState,
                    //                       isEdit: true,
                    //                       onTap: () => _pickAndUploadImage(isCompanyLogo: false),
                    //                       previewBytes: profileImagePreviewBytes,
                    //                       // imageUrl: profileImageImageUrl,
                    //                       imageUrl:
                    //                           companyLogoImageUrl ??
                    //                           getPortfolioImageUrl(
                    //                             portfolio?.personalInfo.profilePicture?.key,
                    //                           ),
                    //                       // (portfolio?.workInfo.companyLogo?.key != null
                    //                       //     ? '$baseUrl/file?key=portfolios/${portfolio?.personalInfo.profilePicture?.key}'
                    //                       //     : null),
                    //                     ),
                  ],
                ),
              ],
            ),
            Gap(CustomPadding.paddingLarge.v),
            PaddingRow(
              children: [
                AddUserLocation(
                  buildingcontroller: buildingController,
                  areacontroller: areaController,
                  pincodecontroller: pincodeController,
                  districtcontroller: districtController,
                  statecontroller: stateController,
                ),
              ],
            ),
            // CommonProductContainer(
            //   title: 'Payment Details',
            //   children: [
            //     Gap(CustomPadding.paddingLarge.v),

            //     Row(
            //       children: [
            //         Expanded(
            //           child: Padding(
            //             padding: EdgeInsets.symmetric(
            //               horizontal: CustomPadding.paddingLarge.v,
            //             ),
            //             child: DropdownButtonFormField<String>(
            //               decoration: InputDecoration(
            //                 labelText: 'Payment Mode',
            //                 labelStyle: context.inter40016,
            //                 border: OutlineInputBorder(),
            //               ),
            //               items:
            //                   ['Prepaid', 'Postpaid'].map((String payment) {
            //                     return DropdownMenuItem<String>(
            //                       value: payment,
            //                       child: Text(payment),
            //                     );
            //                   }).toList(),
            //               onChanged: (value) {
            //                 String? payment;
            //                 setState(() => payment = value);
            //                 logInfo('Selected: $value');
            //               },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please select a category';
            //                 }
            //                 return null;
            //               },
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: TextFormContainer(labelText: 'Transaction ID'),
            //         ),
            //       ],
            //     ),
            //     Gap(CustomPadding.paddingLarge.v),
            //     Row(
            //       children: [
            //         Gap(CustomPadding.paddingLarge.v),
            //         Text('Total Amount'),
            //         Spacer(),
            //         Text('₹$grandTotal', style: context.inter50016),
            //         Gap(CustomPadding.paddingLarge.v),
            //       ],
            //     ),
            //     Gap(CustomPadding.paddingLarge.v),
            //   ],
            // ),
            Gap(CustomPadding.paddingXXL.v),
          ],
        ),
      ),
    );
  }
}
