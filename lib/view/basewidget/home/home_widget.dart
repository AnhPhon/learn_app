import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class HomeWidget extends StatelessWidget {
  final String fullname;
  final Widget content;
  const HomeWidget({required this.fullname, required this.content});

  @override
  Widget build(BuildContext context) {
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
              top: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Container(
                padding:
                    const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                            margin: const EdgeInsets.only(
                                right: Dimensions.MARGIN_SIZE_SMALL),
                            child: const Icon(Icons.menu, color: Colors.white),
                          ),
                        );
                      },
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
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                    const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL)
                  ],
                ),
              ),
            ),
          ]),
        ),

        // white
        Positioned(
          top: 140,
          child: Container(
            alignment: Alignment.topLeft,
            height: DeviceUtils.getScaledHeight(context, 1) - 180,
            width: DeviceUtils.getScaledWidth(context, 1),
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
                width: DeviceUtils.getScaledWidth(context, 1),
                child: content,
              ),
            ),
          ),
        )
      ],
    );
  }
}
