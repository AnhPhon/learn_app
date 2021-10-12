import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/account/account_page.dart';
import 'package:template/view/screen/v1-customer/entertainment/entertainment_page.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';
import 'package:template/view/screen/v1-customer/news/news_page.dart';
import 'package:template/view/screen/v1-customer/project/project_page.dart';

import 'dashboard_controller.dart';

class V1DashboardPage extends StatelessWidget {
  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1DashboardController>(
      init: V1DashboardController(),
      builder: (controller) {
        return Scaffold(
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
