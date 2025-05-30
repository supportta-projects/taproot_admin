import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/data/product_category_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_service.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddProduct extends StatefulWidget {
  final VoidCallback onBack;
  // final ProductCategory ? productCategory;

  // final Future<void> Function()? fetchCategoryFunction;
  final Future<void> Function()? onSave;
  const AddProduct({super.key, required this.onBack, this.onSave});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _templateNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // final TextEditingController _designTypeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String templateName = '';
  String price = '';
  String discountPrice = '';
  String description = '';
  List<ProductCategory> productCategories = [];
  List<String> uploadedImageKeys = [];

  ProductCategory? selectedCategory;
  final List<File?> _selectedImages = [null, null, null, null];

  void pickImage(int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.first;

      setState(() {
        _selectedImages[index] = File(pickedFile.path!);
      });

      final imageBytes = pickedFile.bytes;
      final filename = pickedFile.name;

      if (imageBytes != null) {
        final uploadResult = await ProductService.uploadImageFile(
          imageBytes,
          filename,
        );
        setState(() {
          uploadedImageKeys.add(uploadResult['key']);
        });
        logSuccess('name: ${uploadResult['name']}');
        logSuccess('key: ${uploadResult['key']}');
        logSuccess('size: ${uploadResult['size']}');
        logSuccess('mimetype: ${uploadResult['mimetype']}');
      }
    }
  }

  void removeImage(int index) {
    setState(() {
      _selectedImages[index] = null;

      for (int i = index + 1; i < _selectedImages.length; i++) {
        _selectedImages[i] = null;
      }
    });
  }

  Future<void> addProduct() async {
    try {
      List<ProductImage> productImages = [];
      for (var image in _selectedImages) {
        if (image != null) {
          final uploadResult = await ProductService.uploadImageFile(
            image.readAsBytesSync(),
            image.path.split('/').last,
          );
          productImages.add(
            ProductImage(
              name: uploadResult['name'],
              key: uploadResult['key'],
              size: uploadResult['size'],
              mimetype: uploadResult['mimetype'],
            ),
          );
        }
      }
      await ProductService.addProduct(
        name: _templateNameController.text,
        categoryId: selectedCategory!.id,
        description: _descriptionController.text,
        actualPrice: double.tryParse(_priceController.text) ?? 0.0,
        discountPrice: double.tryParse(_discountPriceController.text) ?? 0.0,
        discountPercentage:
            double.tryParse(_discountPriceController.text) ?? 0.0,
        productImages: productImages,
      );
      logSuccess('Product added successfully');
    } catch (e) {
      logError('Error: $e');
    }
  }

  Future<void> fetchProductCategories() async {
    try {
      final response = await ProductService.getProductCategory();
      setState(() {
        productCategories = response;
        if (productCategories.isNotEmpty) {
          selectedCategory = productCategories[0];
        }
      });
    } catch (e) {
      logError('Error fetching product categories: $e');
    }
  }

  @override
  void initState() {
    fetchProductCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gap(CustomPadding.paddingXL.v),
              Row(
                children: [
                  Gap(CustomPadding.paddingXL.v),
                  GestureDetector(
                    onTap: () {
                      widget.onBack();
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
                  Text('Add Product', style: context.inter60016),
                  Spacer(),
                  MiniGradientBorderButton(
                    text: 'Back',
                    icon: Icons.arrow_back,
                    onPressed: widget.onBack,
                    gradient: LinearGradient(
                      colors: CustomColors.borderGradient.colors,
                    ),
                  ),
                  Gap(CustomPadding.paddingLarge.v),
                  //TODO: image
                  MiniLoadingButton(
                    icon: LucideIcons.save,
                    text: 'Save',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addProduct();
                        await widget.onSave!();
                        Navigator.pop(context);
                      }
                    },
                    useGradient: true,
                    gradientColors: CustomColors.borderGradient.colors,
                  ),
                  Gap(CustomPadding.paddingXL.v),
                ],
              ),
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
                    ProductIdContainer(productId: 'Product ID'),
                    Gap(CustomPadding.paddingXL.v),
                    Row(
                      children: List.generate(4, (index) {
                        if (index == 0 || _selectedImages[index - 1] != null) {
                          return AddImageContainer(
                            selectedImage: _selectedImages[index],
                            pickImage: () => pickImage(index),
                            removeImage: () => removeImage(index),
                            imagekey:
                                uploadedImageKeys.isNotEmpty &&
                                        index < uploadedImageKeys.length
                                    ? uploadedImageKeys[index]
                                    : null,
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),

                    Gap(CustomPadding.paddingLarge.v),
                    Text(
                      'You can Choose a Maximum of 4 Photos. JPG, GIF, or PNG. Max size of 800K',
                      style: TextStyle(color: CustomColors.hintGrey),
                    ),
                    Gap(CustomPadding.paddingLarge.v),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormContainer(
                            controller: _templateNameController,
                            initialValue: '',
                            labelText: 'Template Name',
                            onChanged: (value) {
                              setState(() {
                                templateName = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormContainer(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            controller: _discountPriceController,
                            suffixText: '%',
                            initialValue: '',
                            labelText: 'Discount Percentage',
                            onChanged: (value) {
                              discountPrice = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a discount percentage';
                              }
                              final percentage = int.tryParse(value);
                              if (percentage == null ||
                                  percentage < 1 ||
                                  percentage > 99) {
                                return 'Please enter a percentage between 1 and 99';
                              }
                              return null;
                            },
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: _priceController,
                                initialValue: '',
                                labelText: 'Price',
                                onChanged: (value) {
                                  price = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a price';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  Gap(CustomPadding.paddingLarge.v),
                                  Text('Design Type'),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            CustomPadding.paddingLarge.v,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            CustomPadding.paddingLarge.v,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          CustomPadding.paddingSmall.v,
                                        ),
                                        border: Border.all(
                                          color:
                                              CustomColors.textColorLightGrey,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<ProductCategory>(
                                          underline: null,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          isExpanded: true,
                                          borderRadius: BorderRadius.circular(
                                            CustomPadding.padding.v,
                                          ),
                                          value: selectedCategory,
                                          items:
                                              productCategories.map((category) {
                                                return DropdownMenuItem(
                                                  value: category,
                                                  child: Text(category.name),
                                                );
                                              }).toList(),

                                          onChanged: (
                                            ProductCategory? newValue,
                                          ) {
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
                            controller: _descriptionController,
                            maxline: 4,
                            initialValue: '',
                            labelText: 'Description',
                            onChanged: (value) {
                              description = value;
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.split(' ').length < 5) {
                                return 'Please enter at least 5 words';
                              }
                              return null;
                            },
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
      ),
    );
  }
}

class AddImageContainer extends StatelessWidget {
  final VoidCallback removeImage;
  final VoidCallback pickImage;
  final File? selectedImage;
  final bool isImageView;
  final String? path;
  final File? file;
  final String? imagekey;

  const AddImageContainer({
    super.key,
    required this.removeImage,
    required this.pickImage,
    this.selectedImage,
    this.isImageView = false,
    this.path,
    this.file,
    this.imagekey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: CustomPadding.paddingLarge.v),
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          width: 200.v,
          height: 150.h,
          decoration: BoxDecoration(
            color: CustomColors.lightGreen,
            borderRadius: BorderRadius.circular(CustomPadding.padding.v),
          ),
          child:
              isImageView
                  ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          CustomPadding.padding.v,
                        ),
                        child: Image.network(
                          '$baseUrl/file?key=products/$path',
                        ),
                        // Image.file(File(path.toString()), fit: BoxFit.cover),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              removeImage();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: 30.v,
                              color: CustomColors.secondaryColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                    CustomPadding.padding.v,
                                  ),
                                ),
                                gradient: CustomColors.borderGradient,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Replace',
                                    style: context.inter60012.copyWith(
                                      color: CustomColors.secondaryColor,
                                    ),
                                  ),
                                  Gap(CustomPadding.padding.v),
                                  Icon(
                                    Icons.repeat,
                                    color: CustomColors.secondaryColor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : Center(
                    child:
                        selectedImage == null
                            ? Icon(
                              Icons.add,
                              size: 40.v,
                              color: CustomColors.greenDark,
                            )
                            : Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    CustomPadding.padding.v,
                                  ),
                                  child: Image.network(
                                    '$baseUrl/file?key=products/$imagekey',
                                    fit: BoxFit.cover,
                                  ),
                                  //  Image.file(
                                  //   selectedImage!,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        removeImage();
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        size: 30.v,
                                        color: CustomColors.secondaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(
                                              CustomPadding.padding.v,
                                            ),
                                          ),
                                          gradient: CustomColors.borderGradient,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Replace',
                                              style: context.inter60012
                                                  .copyWith(
                                                    color:
                                                        CustomColors
                                                            .secondaryColor,
                                                  ),
                                            ),
                                            Gap(CustomPadding.padding.v),
                                            Icon(
                                              Icons.repeat,
                                              color:
                                                  CustomColors.secondaryColor,
                                              size: 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                  ),
        ),
      ),
    );
  }

  // Widget _buildImageFromPath(String? path) {
  //   if (path == null || path.isEmpty) {
  //     return const Icon(Icons.broken_image, size: 50);
  //   }

  //   final isNetwork = path.startsWith('http') || path.startsWith('https');

  //   return isNetwork
  //       ? Image.network(
  //         path,
  //         fit: BoxFit.cover,
  //         errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
  //       )
  //       : Image.file(
  //         File(path),
  //         fit: BoxFit.cover,
  //         errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
  //       );
  // }
}
