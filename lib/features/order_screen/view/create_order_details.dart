// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:taproot_admin/exporter/exporter.dart';
// import 'package:taproot_admin/features/order_screen/data/order_service.dart';
// import 'package:taproot_admin/features/product_screen/data/product_model.dart';
// import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
// import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
// import 'package:taproot_admin/widgets/common_product_container.dart';
// import 'package:taproot_admin/widgets/gradient_border_container.dart';
// import 'package:taproot_admin/widgets/mini_gradient_border.dart';
// import 'package:taproot_admin/widgets/mini_loading_button.dart';

// class CreateOrderDetails extends StatefulWidget {
//   final Future<void> Function(String) fetchUser;
//   final List<UserSearch> userSearchList;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String whatsAppNumber;

//   const CreateOrderDetails({
//     super.key,
//     required this.fetchUser,
//     required this.email,
//     required this.userSearchList,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.whatsAppNumber,
//   });

//   @override
//   State<CreateOrderDetails> createState() => _CreateOrderDetailsState();
// }

// class _CreateOrderDetailsState extends State<CreateOrderDetails> {
//   UserSearch? userSearchList;
//   List<ProductSearch> productSearchList = [];

//   String? orderId;
//   bool isLoading = false;
//   bool isSearching = false;
//   bool isLoadingProduct = false;
//   bool isSearchingProduct = false;
//   @override
//   void initState() {
//     getOrderId();
//     // TODO: implement initState
//     super.initState();
//   }

//   Future<void> getOrderId() async {
//     try {
//       setState(() => isLoading = true);

//       final result = await OrderService.getOrderId();
//       setState(() {
//         orderId = result;
//         isLoading = false;
//       });

//       logSuccess("Order ID: $orderId"); // For debugging
//     } catch (e) {
//       setState(() => isLoading = false);
//       logError('Error fetching order ID: $e');
//     }
//   }

//   Future<void> fetchProducts(String searchQuery) async {
//     try {
//       setState(() {
//         isLoadingProduct = true;
//       });
//       final response = await OrderService.fetchProduct(searchQuery);
//       setState(() {
//         productSearchList = response.productSearch;
//         isLoadingProduct = false;
//       });
//     } catch (e) {
//       logError('Error searching product: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Gap(CustomPadding.paddingXL.v),

//           Row(
//             children: [
//               Gap(CustomPadding.paddingXL.v),
//               GestureDetector(
//                 onTap: () {},
//                 child: Text(
//                   'Order',
//                   style: context.inter60016.copyWith(
//                     color: CustomColors.greenDark,
//                   ),
//                 ),
//               ),
//               Gap(CustomPadding.padding.v),
//               Text(
//                 '>',
//                 style: context.inter60016.copyWith(
//                   color: CustomColors.hintGrey,
//                 ),
//               ),
//               Gap(CustomPadding.padding.v),
//               if (isLoading)
//                 SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 )
//               else if (orderId != null)
//                 Text(
//                   orderId!,
//                   style: context.inter60016.copyWith(
//                     color: CustomColors.hintGrey,
//                   ),
//                 )
//               else
//                 Text(
//                   'No Order ID',
//                   style: context.inter60016.copyWith(
//                     color: CustomColors.hintGrey,
//                   ),
//                 ),
//               Spacer(),
//               MiniGradientBorderButton(
//                 text: 'Cancel',
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },

//                 gradient: LinearGradient(
//                   colors: CustomColors.borderGradient.colors,
//                 ),
//               ),
//               Gap(CustomPadding.paddingLarge.v),
//               MiniLoadingButton(
//                 icon: LucideIcons.save,
//                 text: 'Save',
//                 onPressed: () {},
//                 useGradient: false,
//                 backgroundColor: CustomColors.hintGrey,
//               ),
//               Gap(CustomPadding.paddingLarge.v),
//             ],
//           ),
//           Gap(CustomPadding.paddingLarge.v),
//           CommonProductContainer(
//             title: 'Order Details',
//             children: [
//               Gap(CustomPadding.paddingLarge.v),

//               GradientBorderField(
//                 hintText: 'Search User name, User ID',
//                 onChanged: (value) async {
//                   setState(() {
//                     isSearching = value.isNotEmpty;
//                   });
//                   await widget.fetchUser(value);
//                 },
//               ),
//               Gap(CustomPadding.paddingLarge.v),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else if (isSearching && widget.userSearchList.isNotEmpty)
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: CustomPadding.paddingLarge,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       CustomPadding.padding.v,
//                     ),
//                     border: Border.all(color: CustomColors.hintGrey),
//                   ),
//                   height: 300,
//                   child: ListView.builder(
//                     itemCount: widget.userSearchList.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           ListTile(
//                             onTap: () {},
//                             title: Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: CustomPadding.paddingLarge.v,
//                               ),
//                               child: Text(
//                                 widget.userSearchList[index].fullName,
//                               ),
//                             ),
//                             subtitle: Row(
//                               children: [
//                                 Text(
//                                   'Phone Number- ${widget.userSearchList[index].phone}',
//                                 ),
//                                 Gap(CustomPadding.paddingLarge.v),
//                                 Text(
//                                   'user ID-${widget.userSearchList[index].userId}',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(),
//                           Gap(CustomPadding.paddingLarge.v),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: CustomPadding.paddingXL.v,
//                       ),
//                       child: Column(
//                         spacing: CustomPadding.paddingLarge.v,
//                         children: [
//                           CardRow(
//                             prefixText: 'Order ID',
//                             suffixText: '$orderId',
//                           ),
//                           CardRow(
//                             prefixText: 'Full Name',
//                             suffixText: widget.fullName,
//                           ),
//                           CardRow(
//                             prefixText: 'Email',
//                             suffixText: widget.email,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: CustomPadding.paddingLarge.v,
//                       ),
//                       child: Column(
//                         spacing: CustomPadding.paddingLarge.v,
//                         children: [
//                           CardRow(
//                             prefixText: 'Phone Number',
//                             suffixText: widget.phoneNumber,
//                           ),
//                           CardRow(
//                             prefixText: 'Whatsapp Number',
//                             suffixText: widget.whatsAppNumber,
//                           ),
//                           CardRow(prefixText: '', suffixText: ''),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(CustomPadding.paddingXL.v),
//               CommonProductContainer(
//                 title: 'Choose Product',
//                 children: [
//                   Gap(CustomPadding.paddingLarge.v),
//                   GradientBorderField(
//                     hintText: 'Add Product + ',
//                     onChanged: (value) {
//                       fetchProducts(value);
//                       setState(() {
//                         isSearchingProduct = value.isNotEmpty;
//                       });
//                     },
//                   ),
//                   if (isLoadingProduct)
//                     CircularProgressIndicator()
//                   else if (isSearchingProduct && productSearchList.isNotEmpty)
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: CustomPadding.paddingLarge,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           CustomPadding.padding.v,
//                         ),
//                         border: Border.all(color: CustomColors.hintGrey),
//                       ),
//                       height: 300,
//                       child: ListView.builder(
//                         itemCount: productSearchList.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 onTap: () {},
//                                 title: Padding(
//                                   padding: EdgeInsets.only(
//                                     bottom: CustomPadding.paddingLarge.v,
//                                   ),
//                                   child: Text(
//                                     productSearchList[index].name.toString(),
//                                   ),
//                                 ),
//                                 trailing: Column(
//                                   children: [
//                                     Text(
//                                       ' ₹${productSearchList[index].salePrice.toString()}',
//                                       style: context.inter50014,
//                                     ),
//                                     Text('Price'),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   Gap(CustomPadding.paddingLarge.v),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/order_screen/widgets/product_card.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
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
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  UserSearch? userSearchList;
  List<ProductSearch> productSearchList = [];
  List<ProductSearch> selectedProducts = [];
  Map<String?, int> productQuantities = {};

  String? orderId;
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

  void _pickAndUploadImage({required bool isCompanyLogo}) async {
    final picked = await ImagePickerService.pickImage();
    if (picked != null) {
      setState(() {
        if (isCompanyLogo) {
          companyLogoPreviewBytes = picked.bytes;
          companyLogoUploadState = 'Uploading...';
        } else {
          profileImagePreviewBytes = picked.bytes;
          profileImageUploadState = 'Uploading...';
        }
      });

      final uploaded = await ImagePickerService.uploadImageFile(
        picked.bytes,
        picked.filename,
      );
      setState(() {
        if (isCompanyLogo) {
          companyLogoImageUrl = uploaded.url;
          companyLogoUploadState = 'Uploaded';
        } else {
          profileImageImageUrl = uploaded.url;
          profileImageUploadState = 'Uploaded';
        }
      });
    }
  }

  @override
  void initState() {
    getOrderId();
    super.initState();
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

                TextFormContainer(readonly: true, labelText: 'Full Name'),
                Gap(CustomPadding.paddingLarge.v),
                TextFormContainer(readonly: true, labelText: 'Designation'),
                Gap(CustomPadding.paddingXL.v),

                Row(
                  children: [
                    Gap(CustomPadding.paddingXL.v),
                    ImageContainer(
                      title: 'Company Logo',
                      icon: LucideIcons.upload,
                      imageState: companyLogoUploadState,
                      isEdit: true,
                      onTap: () => _pickAndUploadImage(isCompanyLogo: true),
                      previewBytes: companyLogoPreviewBytes,
                      imageUrl: companyLogoImageUrl,
                    ),
                    Gap(CustomPadding.paddingXL.v),

                    ImageContainer(
                      title: 'Profile Image',
                      icon: LucideIcons.upload,
                      imageState: profileImageUploadState,
                      isEdit: true,
                      onTap: () => _pickAndUploadImage(isCompanyLogo: false),
                      previewBytes: profileImagePreviewBytes,
                      imageUrl: profileImageImageUrl,
                    ),

                    // isEdit
                    // ? ImageContainer(
                    //       selectedFile: selectedImageLoco,
                    //       isEdit: true,
                    //       icon:
                    //           selectedImageLoco == null
                    //               ? LucideIcons.upload
                    //               : LucideIcons.repeat,
                    //       title: 'Loco',
                    //       onTap: () => pickImage(isLogo: true),
                    //       imageState:
                    //           selectedImageLoco == null
                    //               ? 'Upload'
                    //               : 'Replace',
                    //     )
                    //     : ImageContainer(
                    //       onTap: () {},
                    //       isEdit: false,
                    //       title: 'Loco',
                    //       icon: LucideIcons.upload,
                    //       imageState: 'Upload',
                    //       selectedFile: null,
                    //     ),
                    // isEdit
                    //     ? ImageContainer(
                    //       onTap: () => pickImage(isLogo: false),
                    //       isEdit: true,
                    //       title: 'Banner Image',
                    //       icon:
                    //           selectedImageBanner == null
                    //               ? LucideIcons.upload
                    //               : LucideIcons.repeat,
                    //       imageState:
                    //           selectedImageBanner == null
                    //               ? 'Upload'
                    //               : 'Replace',
                    //       selectedFile: selectedImageBanner,
                    //     )
                    //     : ImageContainer(
                    //       onTap: () {},
                    //       icon: LucideIcons.upload,
                    //       title: 'Banner Image',
                    //       imageState: 'Upload',
                    //       selectedFile: null,
                    //     ),
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
            Gap(CustomPadding.paddingLarge.v),
            CommonProductContainer(
              title: 'Payment Details',
              children: [
                TextFormContainer(labelText: 'Transaction ID'),
                TextFormContainer(labelText: 'Transaction ID'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
