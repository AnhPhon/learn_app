import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/account/account_page.dart';
import 'package:template/view/screen/cart/cart_page.dart';
import 'package:template/view/screen/home/home_page.dart';
import 'package:template/view/screen/leaderboard/leaderboard_page.dart';
import 'package:template/view/screen/news/news_page.dart';
import 'package:template/view/screen/posts/posts_page.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {

  ///
  /// build method (override)
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                CartPage(),
                LeaderBoardPage(),
                NewsPage(),
                AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Trang chủ',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.cart,
                label: 'Giỏ hàng',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.chart_bar,
                label: 'Bảng xếp hạng',
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
