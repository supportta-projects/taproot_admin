import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/side_nav_screen/controllers/nav_controllers.dart';
import 'package:taproot_admin/gen/assets.gen.dart';

import '../widgets/side_menu_lucide_icon_widgt.dart';

class SideDrawerNavScreen extends StatefulWidget {
  static const String path = '/sideDrawerNav';
  const SideDrawerNavScreen({super.key});

  @override
  State<SideDrawerNavScreen> createState() => _SideDrawerNavScreenState();
}

class _SideDrawerNavScreenState extends State<SideDrawerNavScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    NavControllers.sideMenuController.addListener((index) {
      setState(() {
        _currentIndex = index;
        NavControllers.pageController.jumpToPage(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight.h,
        leading: SvgPicture.asset(
          Assets.svg.logo,
          height: SizeUtils.height * 0.05,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          SideMenu(
            controller: NavControllers.sideMenuController,
            style: SideMenuStyle(
              backgroundColor: Colors.white,
              displayMode: SideMenuDisplayMode.open,
              openSideMenuWidth: (150 / 1440) * SizeUtils.width,
              selectedColor: CustomColors.primaryColor,
              // selectedIconColor: Colors.blue,
              selectedTitleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.fSize,
                fontWeight: FontWeight.bold,
              ),
              unselectedTitleTextStyle: TextStyle(
                color: CustomColors.textColorDarkGrey,
                fontSize: 14.fSize,
              ),
              hoverColor: CustomColors.hoverColor,
              itemOuterPadding: EdgeInsets.symmetric(
                vertical: CustomPadding.paddingSmall.v,
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.clipboardMinus,
                  index: 0,
                  currentIndex: _currentIndex,
                ),
                onTap: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                  NavControllers.sideMenuController.changePage(index);
                },
              ),
              SideMenuItem(
                title: 'Orders',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.box,
                  index: 1,
                  currentIndex: _currentIndex,
                ),
                onTap: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                  NavControllers.sideMenuController.changePage(index);
                },
              ),
              SideMenuItem(
                title: 'Profile',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.user,
                  index: 2,
                  currentIndex: _currentIndex,
                ),
                onTap: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                  NavControllers.sideMenuController.changePage(index);
                },
              ),
              SideMenuItem(
                title: 'Settings',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.settings,
                  index: 3,
                  currentIndex: _currentIndex,
                ),
                onTap: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                  NavControllers.sideMenuController.changePage(index);
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: NavControllers.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    'Dashboard Page',
                    style: TextStyle(fontSize: 14.fSize),
                  ),
                ),
                Center(
                  child: Text(
                    'Orders Page',
                    style: TextStyle(fontSize: 14.fSize),
                  ),
                ),
                Center(
                  child: Text(
                    'Profile Page',
                    style: TextStyle(fontSize: 14.fSize),
                  ),
                ),
                Center(
                  child: Text(
                    'Settings Page',
                    style: TextStyle(fontSize: 14.fSize),
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
