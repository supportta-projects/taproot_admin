import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/product_screen/data/product_model.dart';
import 'package:taproot_admin/features/product_screen/data/product_service.dart';
import 'package:taproot_admin/features/product_screen/widgets/card_row.dart';
import 'package:taproot_admin/features/product_screen/widgets/edit_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_id_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/add_image_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class ViewProduct extends StatefulWidget {
  final Product? product;
  final String? productName;
  final String? price;
  final String? offerPrice;
  final String? description;
  final String? cardType;
  final List<String>? images;
  // final Future<Product?> Function(String) onRefresh;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  // final Future<void> Function() onEdit;
  const ViewProduct({
    super.key,
    required this.onBack,
    required this.onEdit,
    this.images,
    this.productName,
    this.price,
    //  required this.onRefresh,
    this.offerPrice,
    this.description,
    this.cardType,
    this.product,
  });

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool isEdit = false;
  Product? currentProduct;
  List<String> currentImages = [];
  // bool viewProduct=false;

  //   @override
  //   void initState() {
  //     // TODO: implement initState
  //         currentProduct = widget.product;
  // refreshProduct();
  //     super.initState();
  //   }

  Future<void> refreshProduct() async {
    try {
      if (currentProduct?.id != null) {
        final updatedProduct = await ProductService.getProductById(
          currentProduct!.id.toString(),
        );
        setState(() {
          currentProduct = updatedProduct;
          currentImages = widget.images ?? [];
          //           currentImages =
          // updatedProduct?.productImages?.map((e) => e.key).toList() ?? [];
        });
      }
    } catch (e) {
      logError('Error refreshing product: $e');
    }
  }

  @override
  void initState() {
    currentProduct = widget.product;
    // TODO: implement initState
    super.initState();
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
                onTap: () {
                  widget.onBack();
                  // setState(() {
                  //   viewProduct = !viewProduct;
                  // });
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
              Text('${widget.product!.name}', style: context.inter60016),
              Spacer(),
              MiniLoadingButton(
                icon: Icons.edit,
                text: 'Edit',
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => EditProduct(
                            product: currentProduct,
                            onRefreshProduct:
                                () {}, // no need, we handle it here
                          ),
                    ),
                  );

                  if (result == true) {
                    await refreshProduct(); // refresh only if update succeeded
                  }

                  //  widget.onEdit();
                  //         await refreshProduct();
                },
                useGradient: true,
                gradientColors: CustomColors.borderGradient.colors,
              ),
              Gap(CustomPadding.paddingLarge.v),
              MiniGradientBorderButton(
                text: 'Back',
                icon: Icons.arrow_back,
                onPressed: () {
                  widget.onBack();
                  // setState(() {
                  //   viewProduct = !viewProduct;
                  // });
                },

                gradient: LinearGradient(
                  colors: CustomColors.borderGradient.colors,
                ),
              ),
              Gap(CustomPadding.paddingLarge.v),
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
              borderRadius: BorderRadius.circular(CustomPadding.paddingLarge.v),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductIdContainer(productId: widget.product!.code.toString()),
                Gap(CustomPadding.paddingLarge.v),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    widget.images?.length ?? 0,
                    (index) => SizedBox(
                      width: SizeUtils.width / 5,
                      child: AddImageContainer(
                        isImageView: true,
                        imageUrl:
                            '$baseUrlImage/products/${widget.images![index]}',
                      ),
                    ),
                  ),
                ),
                Gap(CustomPadding.paddingLarge.v),
                Container(
                  margin: EdgeInsets.only(left: CustomPadding.paddingXL.v),
                  width: SizeUtils.width / 2.5,
                  child: Column(
                    spacing: CustomPadding.paddingLarge.v,
                    children: [
                      CardRow(
                        prefixText: 'Template Name',
                        suffixText: widget.product?.name ?? '',
                      ),
                      CardRow(
                        prefixText: 'Price',
                        suffixText: "₹${widget.product!.actualPrice}",
                      ),
                      CardRow(
                        prefixText: 'Discounted Price',
                        suffixText: "₹${widget.product!.salePrice} ",
                      ),
                      CardRow(
                        prefixText: 'Design Type',
                        suffixText: widget.product!.category!.name.toString(),
                      ),
                      CardRow(
                        prefixText: 'Description',
                        suffixText: '${widget.product!.description}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
