import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class HomeWidget extends StatelessWidget {
  String fullname;
  Widget content;
  HomeWidget({required this.fullname, required this.content});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: ColorResources.THEME_DEFAULT,
          ),
          child: Stack(children: [
            Positioned(
              top: -20,
              left: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                      ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -80,
              right: -20,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                      ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              // left: 15,
              width: size.width,
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(Icons.menu, color: Colors.white),
                      ),
                    ),
                    Text(
                      fullname,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.V1_NOTIFICATION);
                        },
                        child: const Icon(
                          CupertinoIcons.bell_fill,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              ),
            ),
          ]),
        ),

        // white
        Positioned(
          top: 100,
          child: Container(
            alignment: Alignment.topLeft,
            height: size.height - 180,
            width: size.width,
            margin: const EdgeInsets.only(),
            padding: const EdgeInsets.all(
              Dimensions.PADDING_SIZE_DEFAULT,
            ),
            decoration: const BoxDecoration(
              color: Color(0xffF6F6F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                topRight: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
              ),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                child: content,
              ),
            ),
          ),
        )
      ],
    );
  }
}
