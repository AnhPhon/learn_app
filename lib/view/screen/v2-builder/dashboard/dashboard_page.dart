import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v2-builder/account/account_page.dart';
import 'package:template/view/screen/v2-builder/entertainment/entertainment_page.dart';
import 'package:template/view/screen/v2-builder/home/home_page.dart';
import 'package:template/view/screen/v2-builder/news/news_page.dart';
import 'package:template/view/screen/v2-builder/project/project_page.dart';

import 'dashboard_controller.dart';

// ignore: must_be_immutable
class V2DashboardPage extends StatelessWidget {
  V2DashboardController v2dashboardController = V2DashboardController();

  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2DashboardController>(
      init: v2dashboardController,
      builder: (controller) {
        return Builder(
          builder: (context) {
            return WillPopScope(
              onWillPop: () => controller.onDoubleBack(),
              child: Scaffold(
                body: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    V2HomePage(v2DashboardController: v2dashboardController),
                    V2ProjectPage(),
                    V2EntertainmentPage(),
                    V2NewsPage(),
                    V2AccountPage(),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: ColorResources.PRIMARY,
                  backgroundColor: ColorResources.WHITE,
                  onTap: controller.changeTabIndex,
                  currentIndex: controller.tabIndex,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  items: [
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.home,
                      label: 'Trang chủ',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.bag_fill,
                      label: 'Dự án',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.star_lefthalf_fill,
                      label: 'Giải trí',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.news,
                      label: 'Tin tức',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.person,
                      label: 'Tài khoản',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///
  /// _bottomNavigationBarItem
  ///
  BottomNavigationBarItem _bottomNavigationBarItem(
      {IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
