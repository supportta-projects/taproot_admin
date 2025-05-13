import 'package:flutter/material.dart';

import 'package:taproot_admin/features/product_screen/widgets/add_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_page.dart';
import 'package:taproot_admin/features/product_screen/widgets/view_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const path = '/productScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // List<bool> enabledList = List.generate(7, (index) => true);
  bool addProduct = false;
  bool viewProduct = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future<void> fetchProduct() async {
  //   try {
  //     final response = await ProductService.getProduct();
  //     setState(() {
  //       products = response;
  //       if (products != null && products!.results.isNotEmpty) {
  //         enabledList = List.generate(
  //           products!.results.length,
  //           (index) => true,
  //         );
  //       } else {
  //         enabledList = [];
  //       }
  //     });
  //   } catch (e) {
  //     // Handle error
  //     logError('Error fetching products: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return viewProduct
        ? ViewProduct(
          onEdit: () {
            // Navigator.of(
            //   context,

            // ).pushNamed(EditProduct.path);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => EditProduct()),
            // );
          },
          onBack: () {
            setState(() {
              viewProduct = false;
            });
          },
        )
        : addProduct
        ? AddProduct(
          onBack: () {
            setState(() {
              addProduct = false;
            });
          },
        )
        : ProductPage(
          addTap: () {
            setState(() {
              addProduct = true;
            });
          },
          viewTap: () {
            setState(() {
              viewProduct = true;
            });
          },
        );
  }
}
