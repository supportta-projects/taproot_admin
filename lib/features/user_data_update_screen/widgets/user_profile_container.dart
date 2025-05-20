import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_service.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/gen/assets.gen.dart';









class UserProfileContainer extends StatefulWidget {
  
  final PortfolioDataModel? portfolio;
  final dynamic user;
  final bool isEdit;
  final ValueChanged<bool> onPremiumChanged;
  final String? imageUrl;
  final VoidCallback? onTapEdit;
  final Uint8List? previewImageBytes;

  const UserProfileContainer({
    super.key,
    this.isEdit = false,
    required this.user,
    this.portfolio,
    required this.onPremiumChanged,
    this.imageUrl,
    this.onTapEdit,
    this.previewImageBytes,
  });

  @override
  State<UserProfileContainer> createState() => _UserProfileContainerState();
}

class _UserProfileContainerState extends State<UserProfileContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final User user;
  bool isPremiumSelected = false;
  bool isUserPremium = false ;
  String userType = "";

  Color chipColor = Colors.transparent;



  @override
  void initState() {
    super.initState();
    // isUserPremium = user.isPremium;
    isPremiumSelected = widget.portfolio?.user.isPremium ?? false;
    _tabController =
        TabController(length: 2, vsync: this)
          ..index = isPremiumSelected ? 1 : 0
          ..addListener(() {
            if (!_tabController.indexIsChanging) {
              final newVal = _tabController.index == 1;
              if (newVal != isPremiumSelected) {
                setState(() => isPremiumSelected = newVal);
                widget.onPremiumChanged(newVal);
              }
            }
          });
  }





  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> isPremiumm() async {
    final response = await PortfolioService.isUserPremium(
      userId: widget.portfolio!.user.id,
    );
    response;
  }



  void setUserType (){

//TODo: Aswin M
if(isUserPremium)
  {  setState(() {
      userType = "Premium";
      chipColor =       CustomColors.buttonColor1;

    });}

else{
  setState(() {
    userType='Basic';
  });
}

  }

  @override
  Widget build(BuildContext context) {
    logError("The user is premium:  $isUserPremium");
    

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(CustomPadding.padding),
        ),
        height: SizeUtils.height * 0.40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Stack(
              children: [
                Container(
                  width: 200.v,
                  height: 200.v,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      CustomPadding.paddingXXL,
                    ),
                    color: CustomColors.textColorLightGrey,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      CustomPadding.paddingXXL,
                    ),
                    child:
                        widget.previewImageBytes != null
                            ? Image.memory(
                              widget.previewImageBytes!,
                              fit: BoxFit.cover,
                              cacheWidth: 300,
                              cacheHeight: 300,
                              gaplessPlayback: true,
                            )
                            : (widget.imageUrl != null &&
                                widget.imageUrl!.isNotEmpty)
                            ? CachedNetworkImage(
                              imageUrl: widget.imageUrl!,
                              fit: BoxFit.cover,
                              width: 300, 
                              height: 300, 
                              memCacheWidth: 300,
                              memCacheHeight: 300,
                              maxWidthDiskCache: 300,
                              maxHeightDiskCache: 300,
                              fadeInDuration: const Duration(milliseconds: 300),
                              fadeInCurve: Curves.easeIn,
                              placeholder:
                                  (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      color: Colors.white,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          size: 40.v,
                                          color: CustomColors.textColorDarkGrey,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Failed to load image',
                                          style: TextStyle(
                                            color:
                                                CustomColors.textColorDarkGrey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            )
                            : Center(
                              child: Icon(
                                Icons.person,
                                size: 80.v,
                                color: CustomColors.textColorDarkGrey,
                              ),
                            ),
                  ),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                ),
                if (widget.isEdit)
                  Positioned(
                    top: 1,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(CustomPadding.padding),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: widget.onTapEdit,
                        child: Icon(
                          Icons.edit,
                          color: CustomColors.buttonColor1,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CustomPadding.padding,
              ),
              child: Text(
                widget.user.userId,
                style: context.inter60020.copyWith(fontSize: 20.fSize),
              ),
            ),

            
            if (widget.isEdit)
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    CustomPadding.paddingXL.v,
                  ),
                  color: Colors.white,
                  border: Border.all(color: CustomColors.burgandryRed),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: CustomColors.burgandryRed,
                    borderRadius: BorderRadius.circular(
                      CustomPadding.paddingXL.v,
                    ),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: CustomColors.textColorDarkGrey,
                  tabs: [
                    Tab(text: 'Basic'),
                    Tab(
                      child: Row(
                        children: [
                          Text('Premium'),
                          Gap(CustomPadding.paddingSmall.v),
                          SvgPicture.asset(Assets.svg.premium),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              
              Container(
                width: 150.v,
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    CustomPadding.paddingLarge,
                  ),
                  color: CustomColors.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  


Chip(label: Text('' ))



                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}


































































































































































































































































































