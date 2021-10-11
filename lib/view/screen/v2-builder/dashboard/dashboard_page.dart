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

class V2DashboardPage extends StatelessWidget {
  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2DashboardController>(
      init: V2DashboardController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: controller.tabIndex,
              children: [
                V2HomePage(),
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
