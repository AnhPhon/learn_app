import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v4-employee/account/account_page.dart';
import 'package:template/view/screen/v4-employee/home/home_page.dart';
import 'package:template/view/screen/v4-employee/news/news_page.dart';
import 'package:template/view/screen/v4-employee/notification/notification_page.dart';
import 'package:template/view/screen/v4-employee/report/report_page.dart';

import 'dashboard_controller.dart';

class V4DashboardPage extends StatelessWidget {
  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4DashboardController>(
      init: V4DashboardController(),
      builder: (controller) {
        return Builder(
          builder: (context) {
            return WillPopScope(
              onWillPop: ()=> controller.onDoubleBack(),
              child: Scaffold(
                body: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    V4HomePage(),
                    V4NotificationPage(),
                    V4NewsPage(),
                    V4ReportPage(),
                    V4AccountPage(),
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
                      icon: CupertinoIcons.bell,
                      label: 'Thông báo',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.news,
                      label: 'Tin tức',
                    ),
                    _bottomNavigationBarItem(
                      icon: CupertinoIcons.pen,
                      label: 'Báo cáo',
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
