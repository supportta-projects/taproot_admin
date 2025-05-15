import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/gradient_border_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  List<UserSearch> userSearchList = [];
  bool isLoading = false;

  @override
  void initState() {
    // fetchUser('');
    // fetchUser();
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchUser(String searchQuery) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await OrderService.fetchUser(searchQuery);
      logSuccess("Fetched ${response.userSearchList.length} users");
      setState(() {
        userSearchList = response.userSearchList;
        isLoading = false;
      });
    } catch (e) {
      logError('Error fetching user: $e');
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

            TextFormContainer(
              labelText: 'Search',
              onChanged: (value) => fetchUser(value),
            ),

            isLoading
                ? CircularProgressIndicator()
                : Container(
                  decoration: BoxDecoration(border: Border.all()),
                  height: 300,
                  child: ListView.builder(
                    itemCount: userSearchList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // shape: ,

                        // style: ,
                        contentPadding: EdgeInsets.all(
                          CustomPadding.paddingLarge.v,
                        ),
                        // focusColor: ,
                        // hoverColor: CustomColors.green,
                        onTap: () {},
                        title: Text(userSearchList[index].fullName),
                      );
                    },
                  ),
                ),

            //             CommonProductContainer(
            //               title: 'Order Details',
            //               children: [
            //                 Gap(CustomPadding.paddingLarge.v),
            //                 GradientBorderField(hintText: 'Search User name, User ID ',onchange: (value) {
            //                   fetchUser(value);
            //                 }, ),
            // isLoading?CircularProgressIndicator():ListView.builder(itemBuilder:(context, index) {
            //   return ListTile(title: Text(userSearchList[index].fullName),);
            // }, ),

            //                 // SearchableList<UserSearch>(
            //                 //   searchFieldEnabled: true,
            //                 //   initialList: userSearchList,
            //                 //   itemBuilder: (item) {
            //                 //     return SizedBox(child: Text(item.fullName));
            //                 //   },
            //                 //   filter: (query) {
            //                 //     searchQuery = query;
            //                 //     return userSearchList
            //                 //         .where((user) => user.fullName.contains(query))
            //                 //         .toList();
            //                 //   },
            //                 // ),
            //                 Gap(CustomPadding.paddingLarge.v),
            //               ],
            //
            //        ),
            CommonProductContainer(
              title: 'Order Details',
              children: [GradientBorderField(hintText: '')],
            ),
            Gap(CustomPadding.paddingXL.v),
            CommonProductContainer(
              title: 'Choose Product',
              children: [
                Gap(CustomPadding.paddingLarge.v),
                GradientBorderField(hintText: 'Add Product + '),
                Gap(CustomPadding.paddingLarge.v),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
