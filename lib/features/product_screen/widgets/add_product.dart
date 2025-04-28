
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddProduct extends StatefulWidget {
  final VoidCallback onBack;
  const AddProduct({super.key, required this.onBack});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String templateName = '';
  String price = '';
  String discountPrice = '';
  String description = '';

  String dropdownvalue = 'Basic';
  var items = ['Premium', 'Basic', 'Modern', 'Classic', 'Business'];
  final List<File?> _selectedImages = [null, null, null, null];

  void _pickImage(int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImages[index] = File(result.files.first.path!);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages[index] = null;

      for (int i = index + 1; i < _selectedImages.length; i++) {
        _selectedImages[i] = null;
      }
    });
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
                MiniLoadingButton(
                  icon: LucideIcons.save,
                  text: 'Save',
                  onPressed: () {
                    final newProduct = {
                      'templateName': templateName,
                      'price': price,
                      'discountPrice': discountPrice,
                      'description': description,
                      'images': _selectedImages
                        .where((image) => image != null)
                        .map((image) => image!.path)
                        .toList(),
                      'type': dropdownvalue,
                    };
                    Navigator.pop(context,newProduct);
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
                  ProductIdContainer(),
                  Gap(CustomPadding.paddingXL.v),
                  Row(
                    children: List.generate(4, (index) {
                      if (index == 0 || _selectedImages[index - 1] != null) {
                        return AddImageContainer(
                          selectedImage: _selectedImages[index],
                          pickImage: () => _pickImage(index),
                          removeImage: () => _removeImage(index),
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
                          initialValue: '',
                          labelText: 'Template Name',
                          onChanged: (value) {
                            setState(() {
                              templateName = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TextFormContainer(
                          initialValue: '',
                          labelText: 'Discount',
                          onChanged: (value) {
                            discountPrice = value;
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
                              initialValue: '',
                              labelText: 'Price',
                              onChanged: (value) {
                                price = value;
                              },
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
                                      child: DropdownButton(
                                        underline: null,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(
                                          CustomPadding.padding.v,
                                        ),
                                        value: dropdownvalue,
                                        items:
                                            items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                          });
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
                          maxline: 4,
                          initialValue: '',
                          labelText: 'Description',
                          onChanged: (value) {
                            description = value;
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
    );
  }
}

class AddImageContainer extends StatelessWidget {
  final VoidCallback removeImage;
  final VoidCallback pickImage;
  final File? selectedImage;
  final bool isImageView;
  final String? path;

  const AddImageContainer({
    super.key,
    required this.removeImage,
    required this.pickImage,
    this.selectedImage,
    this.isImageView=false,
    this.path,
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
          child:isImageView?Stack(fit: StackFit.expand,children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          CustomPadding.padding.v,
                        ),
                        child: Image.file(File(path.toString()), fit: BoxFit.cover),
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
                    ],) : Center(
            child:
                selectedImage == null
                    ? Icon(Icons.add, size: 40.v, color: CustomColors.greenDark)
                    : Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            CustomPadding.padding.v,
                          ),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
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
                    ),
          ),
        ),
      ),
    );
  }
}
