import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v3-agent/account/account_page.dart';
import 'package:template/view/screen/v3-agent/entertainment/entertainment_page.dart';
import 'package:template/view/screen/v3-agent/home/home_page.dart';
import 'package:template/view/screen/v3-agent/news/news_page.dart';
import 'package:template/view/screen/v3-agent/project/project_page.dart';

import 'dashboard_controller.dart';

class V3DashboardPage extends StatelessWidget {
  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3DashboardController>(
      init: V3DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              V3HomePage(),
              V3ProjectPage(),
              V3EntertainmentPage(),
              V3NewsPage(),
              V3AccountPage(),
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
