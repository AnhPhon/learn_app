import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images.dart';

class AppBarWithTabBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabBar bottom;
  const AppBarWithTabBar({Key? key, required this.title, required this.bottom})
      : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kBottomNavigationBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          )),
      elevation: 1,
      centerTitle: true,
      backgroundColor: ColorResources.WHITE,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: ColorResources.WHITE),
      ),
      flexibleSpace: Image(
        image: const AssetImage(Images.toolbar_background),
        height: kToolbarHeight + MediaQuery.of(context).padding.top,
        fit: BoxFit.cover,
      ),

      //tabbar
      bottom: bottom,
    );
  }
}
