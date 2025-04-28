import 'package:flutter/material.dart';
import 'package:taproot_admin/features/product_screen/widgets/add_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/edit_product.dart';
import 'package:taproot_admin/features/product_screen/widgets/product_page.dart';
import 'package:taproot_admin/features/product_screen/widgets/view_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  static const path = '/productScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<bool> enabledList = List.generate(6, (index) => true);
  bool addProduct = false;
  bool viewProduct = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child:
          viewProduct
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
              ),
    );
  }
}
