import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/data/product_category_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_service.dart';
import 'package:taproot_admin/features/product_screen/widgets/add_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class EditProduct extends StatefulWidget {
  final Product? product;

  final VoidCallback onRefreshProduct;
  final String? productName;
  final String? price;
  final String? offerPrice;
  final String? description;
  final String? cardType;

  const EditProduct({
    super.key,
    this.productName,
    this.price,
    this.offerPrice,
    this.description,
    this.cardType,

    required this.product,
    required this.onRefreshProduct,
  });

  static const path = '/editproduct';

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late String dropdownValue;

  List<String> existingImageUrls = [];
  List<File> selectedImages = [];
  List<String> uploadedImageKeys = [];

  List<ProductCategory> productCategories = [];
  ProductCategory? selectedCategory;
  final Map<int, String> oldImageKeys = {};
  final Map<int, String> tempUploadedKeys = {};
  void _pickImage({required int index, required bool isExistingUrl}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.first;
      final newImage = File(pickedFile.path!);
      final imageBytes = pickedFile.bytes;
      final filename = pickedFile.name;

      if (imageBytes != null) {
        try {
          final uploadResult = await ProductService.uploadImageFile(
            imageBytes,
            filename,
          );

          setState(() {
            if (isExistingUrl && index < existingImageUrls.length) {
              oldImageKeys[index] = existingImageUrls[index];
              tempUploadedKeys[index] = uploadResult['key'];

              if (index >= selectedImages.length) {
                selectedImages.add(newImage);
              } else {
                selectedImages[index] = newImage;
              }
            } else {
              if (index < uploadedImageKeys.length) {
                uploadedImageKeys[index] = uploadResult['key'];
              } else {
                uploadedImageKeys.add(uploadResult['key']);
              }

              if (index >= selectedImages.length) {
                selectedImages.add(newImage);
              } else {
                selectedImages[index] = newImage;
              }
            }
          });

          logSuccess('Upload successful:');
          logSuccess('Key: ${uploadResult['key']}');
          logSuccess('Name: ${uploadResult['name']}');
          logSuccess('Size: ${uploadResult['size']}');
          logSuccess('Mimetype: ${uploadResult['mimetype']}');
        } catch (e) {
          logError('Image upload failed: $e');
          setState(() {
            if (index < selectedImages.length) {
              selectedImages.removeAt(index);
            }
          });
        }
      }
    }
  }

  Future<void> deleteImage(ProductImage image) async {
    try {
      await ProductService.deleteImage(image);
    } catch (e) {
      logError('error delete $e');
    }
  }

  Future<void> updateProduct() async {
    try {
      List<ProductImage> productImages = [];

      for (int i = 0; i < existingImageUrls.length; i++) {
        if (!oldImageKeys.containsKey(i)) {
          String imageUrl = existingImageUrls[i];
          ProductImage? existingImage = widget.product?.productImages
              ?.firstWhere((img) => img.key == imageUrl);
          if (existingImage != null) {
            productImages.add(existingImage);
          }
        } else {
          String newKey = tempUploadedKeys[i] ?? '';

          int fileSize = selectedImages[i].lengthSync();
          String fileName = newKey.split('/').last;
          String extension = fileName.split('.').last.toLowerCase();

          productImages.add(
            ProductImage(
              key: newKey,
              name: fileName,
              size: fileSize,
              mimetype: 'image/$extension',
            ),
          );
        }
      }

      for (
        int i = existingImageUrls.length;
        i < uploadedImageKeys.length;
        i++
      ) {
        String key = uploadedImageKeys[i];

        int fileSize = selectedImages[i].lengthSync();
        String fileName = key.split('/').last;
        String extension = fileName.split('.').last.toLowerCase();

        productImages.add(
          ProductImage(
            key: key,
            name: fileName,
            size: fileSize,
            mimetype: 'image/$extension',
          ),
        );
      }

      logSuccess('Final Product Images to be sent:');
      for (var img in productImages) {
        logSuccess('''
          Image ${productImages.indexOf(img)}:
          - key: ${img.key}
          - name: ${img.name}
          - size: ${img.size}
          - mimetype: ${img.mimetype}
        ''');
      }

      final response = await ProductService.editProduct(
        productId: widget.product!.id.toString(),
        name: nameController.text.trim(),
        actualPrice: double.parse(priceController.text.trim()),
        discountPrice: double.parse(discountController.text.trim()),
        productImages: productImages,
        description: descriptionController.text.trim(),
        categoryId: selectedCategory?.id,
      );

      if (response.success) {
        for (var oldKey in oldImageKeys.values) {
          try {
            await ProductService.deleteImage(ProductImage(key: oldKey));
            logSuccess('Old image deleted: $oldKey');
          } catch (e) {
            logError('Failed to delete old image: $e');
          }
        }

        oldImageKeys.clear();
        tempUploadedKeys.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context);
        widget.onRefreshProduct();
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      logError('Error updating product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception:', '').trim()),
        ),
      );
    }
  }

  void removeImage({required int index, required bool isExistingUrl}) {
    setState(() {
      if (isExistingUrl && index < existingImageUrls.length) {
        existingImageUrls.removeAt(index);
      } else if (!isExistingUrl) {
        final newIndex = index - existingImageUrls.length;
        if (newIndex < selectedImages.length) {
          selectedImages.removeAt(newIndex);
          if (newIndex < uploadedImageKeys.length) {
            uploadedImageKeys.removeAt(newIndex);
          }
        }
      }
    });
  }

  void onCancel() async {
    for (var newKey in tempUploadedKeys.values) {
      try {
        await ProductService.deleteImage(ProductImage(key: newKey));
        logSuccess('New image deleted: $newKey');
      } catch (e) {
        logError('Failed to delete new image: $e');
      }
    }

    setState(() {
      existingImageUrls.clear();
      if (widget.product != null && widget.product!.productImages != null) {
        existingImageUrls.addAll(
          widget.product!.productImages!.map((image) => image.key),
        );
      }

      selectedImages.clear();
      uploadedImageKeys.clear();
      oldImageKeys.clear();
      tempUploadedKeys.clear();
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fetchTextFieldValue();
    fetchProductCategories();
    if (widget.product?.productImages != null) {
      existingImageUrls =
          widget.product!.productImages!.map((image) => image.key).toList();
    }
    selectedImages = [];
    uploadedImageKeys = [];
  }

  void fetchTextFieldValue() {
    nameController.text = widget.product!.name.toString();
    priceController.text = widget.product!.actualPrice.toString();
    discountController.text = widget.product!.discountedPrice.toString();
    descriptionController.text = widget.product!.description.toString();
  }

  Future<void> fetchProductCategories() async {
    try {
      final response = await ProductService.getProductCategory();
      setState(() {
        productCategories = response;
        if (widget.product?.category!.id != null) {
          selectedCategory = productCategories.firstWhere(
            (category) => category.id == widget.product!.category!.id,
            orElse: () => productCategories.first,
          );
        } else if (productCategories.isNotEmpty) {
          selectedCategory = productCategories.first;
        }
      });
    } catch (e) {
      logError('Error fetching product categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(CustomPadding.paddingXL.v),
            Row(
              children: [
                Gap(CustomPadding.paddingXL.v),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Product',
                    style: context.inter60016.copyWith(
                      color: CustomColors.greenDark,
                    ),
                  ),
                ),
                Gap(CustomPadding.padding.v),
                Text('>', style: context.inter60016),
                Gap(CustomPadding.padding.v),
                Text('${widget.productName}', style: context.inter60016),
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
                  onPressed: () async {
                    await updateProduct();
                  },
                  useGradient: true,
                  gradientColors: CustomColors.borderGradient.colors,
                ),
                Gap(CustomPadding.paddingXL.v),
              ],
            ),
            Gap(CustomPadding.paddingLarge.v),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
                vertical: CustomPadding.paddingLarge.v,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(
                  CustomPadding.paddingLarge.v,
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductIdContainer(),
                  Gap(CustomPadding.paddingXL.v),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(4, (index) {
                      if (index < existingImageUrls.length) {
                        if (oldImageKeys.containsKey(index)) {
                          return AddImageContainer(
                            removeImage:
                                () => removeImage(
                                  index: index,
                                  isExistingUrl: true,
                                ),
                            pickImage:
                                () => _pickImage(
                                  index: index,
                                  isExistingUrl: true,
                                ),
                            isImageView: true,
                            selectedImage: selectedImages[index],
                            imagekey: tempUploadedKeys[index],
                            path: tempUploadedKeys[index],
                          );
                        }

                        return AddImageContainer(
                          removeImage:
                              () => removeImage(
                                index: index,
                                isExistingUrl: true,
                              ),
                          pickImage:
                              () =>
                                  _pickImage(index: index, isExistingUrl: true),
                          isImageView: true,
                          path: existingImageUrls[index],
                        );
                      }

                      final newImageIndex = index - existingImageUrls.length;
                      if (newImageIndex < uploadedImageKeys.length) {
                        return AddImageContainer(
                          removeImage:
                              () => removeImage(
                                index: index,
                                isExistingUrl: false,
                              ),
                          pickImage:
                              () => _pickImage(
                                index: index,
                                isExistingUrl: false,
                              ),
                          isImageView: false,
                          selectedImage: selectedImages[newImageIndex],
                          imagekey: uploadedImageKeys[newImageIndex],
                        );
                      }

                      return AddImageContainer(
                        removeImage: () {},
                        pickImage:
                            () =>
                                _pickImage(index: index, isExistingUrl: false),
                        isImageView: false,
                      );
                    }),
                  ),

                  Gap(CustomPadding.paddingLarge.v),

                  Gap(CustomPadding.paddingLarge.v),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormContainer(
                          controller: nameController,
                          labelText: 'Template Name',
                        ),
                      ),
                      Expanded(
                        child: TextFormContainer(
                          controller: discountController,

                          labelText: 'Discount',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormContainer(
                              controller: priceController,

                              labelText: 'Price',
                            ),
                            Row(
                              children: [
                                Gap(CustomPadding.paddingLarge.v),
                                Text('Design Type'),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: CustomPadding.paddingLarge.v,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: CustomPadding.paddingLarge.v,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        CustomPadding.paddingSmall.v,
                                      ),
                                      border: Border.all(
                                        color: CustomColors.textColorLightGrey,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<ProductCategory>(
                                        value: selectedCategory,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(
                                          CustomPadding.padding.v,
                                        ),

                                        items:
                                            productCategories.map((category) {
                                              return DropdownMenuItem(
                                                value: category,
                                                child: Text(category.name),
                                              );
                                            }).toList(),

                                        onChanged: (ProductCategory? newValue) {
                                          setState(() {
                                            selectedCategory = newValue;
                                          });
                                          logSuccess(
                                            'Selected: ${newValue!.name}',
                                          );
                                          logSuccess(
                                            'Selected ID: ${newValue.id}',
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormContainer(
                          controller: descriptionController,
                          maxline: 4,
                          labelText: 'Description',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
