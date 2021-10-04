import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/account/account_page.dart';
import 'package:template/view/screen/v1-customer/entertainment/entertainment_page.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';
import 'package:template/view/screen/v1-customer/news/news_page.dart';
import 'package:template/view/screen/v1-customer/project/home_page.dart';
import 'package:template/view/screen/v4-employee/account/account_page.dart';
import 'package:template/view/screen/v4-employee/home/home_page.dart';
import 'package:template/view/screen/v4-employee/news/news_page.dart';
import 'package:template/view/screen/v4-employee/notification/notification_page.dart';
import 'package:template/view/screen/v4-employee/report/report_page.dart';

import 'dashboard_controller.dart';

class V1DashboardPage extends StatelessWidget {
  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4DashboardController>(
      init: V4DashboardController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: controller.tabIndex,
              children: [
                V1HomePage(),
                V1ProjectPage(),
                V1EntertainmentPage(),
                V1NewsPage(),
                V1AccountPage(),
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
