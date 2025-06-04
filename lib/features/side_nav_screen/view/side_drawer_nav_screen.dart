import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/Dashboard_screen/view/dashboard_screen.dart';
import 'package:taproot_admin/features/Expense_screen/view/expense_view.dart';
import 'package:taproot_admin/features/leads_screen.dart/view/leads.dart';
import 'package:taproot_admin/features/order_screen/view/order_screen.dart';
import 'package:taproot_admin/features/product_screen/views/product_screen.dart';
import 'package:taproot_admin/features/side_nav_screen/controllers/nav_controllers.dart';
import 'package:taproot_admin/features/users_screen/view/user_management_screen.dart';
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

  final GlobalKey<NavigatorState> _innerNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _innerOrderNavigatorKey =
      GlobalKey<NavigatorState>();
  final List<String> _pageTitles = [
    'Dashboard',
    'Orders',
    'Product',
    'Users',
    'Expense',
    'Leads',
  ];

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
        title: Row(
          children: [
            Gap(CustomPadding.paddingXXL.v),
            Text(_pageTitles[_currentIndex]),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          PopupMenuButton<String>(
            offset: Offset(0, CustomPadding.paddingXL.v),
            icon: const Icon(Icons.account_circle),
            onSelected: (value) {
              if (value == 'profile') {
              } else if (value == 'logout') {}
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'profile', child: Text('Profile')),
                  PopupMenuItem(value: 'logout', child: Text('Logout')),
                ],
          ),
          CustomGap.gapXL,
        ],
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(CustomPadding.padding),
          child: Image.asset(
            Assets.png.supporttalogo.path,
            fit: BoxFit.contain,
          ),
        ),
        toolbarHeight: kToolbarHeight.h,

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
              selectedColor: CustomColors.borderGradient.colors.first,

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
                title: 'Product',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.shoppingCart,
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
                title: 'Users',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.users,
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
              SideMenuItem(
                title: 'Expense',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.network,
                  index: 4,
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
                title: 'Leads',
                iconWidget: SideMenuLucideIcon(
                  icon: LucideIcons.briefcaseBusiness,
                  index: 5,
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
                Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(builder: (_) => DashboardScreen());
                  },
                ),
                Navigator(
                  key: _innerOrderNavigatorKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder:
                          (_) => OrderScreen(
                            innerNavigatorKey: _innerOrderNavigatorKey,
                          ),
                    );
                  },
                ),
                Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => ProductScreen(),
                      settings: settings,
                    );
                  },
                ),

                Navigator(
                  key: _innerNavigatorKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder:
                          (_) => UserManagementScreen(
                            innerNavigatorKey: _innerNavigatorKey,
                          ),
                      settings: settings,
                    );
                  },
                ),
                Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => ExpenseView(),
                      settings: settings,
                    );
                  },
                ),
                Navigator(
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => LeadScreen(),
                      settings: settings,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
