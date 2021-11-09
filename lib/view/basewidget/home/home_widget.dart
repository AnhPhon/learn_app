import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class HomeWidget extends StatelessWidget {
  final String fullname;
  final Widget content;
  String? notificationURL;
  String? imageNetwork;
  int? soThongBao;
  bool? isNotNotification;
  HomeWidget(
      {required this.fullname,
      required this.content,
      this.notificationURL,
      this.imageNetwork,
      this.isNotNotification = true,
      this.soThongBao});

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
                            child: (imageNetwork == null)
                                ? const Icon(
                                    Icons.menu,
                                    color: ColorResources.WHITE,
                                  )
                                : FadeInImage.assetNetwork(
                                    placeholder: Images.logo,
                                    image: imageNetwork!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
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
                      child: isNotNotification == true
                          ? GestureDetector(
                              onTap: () {
                                if (notificationURL == null) {
                                  sl.get<SharedPreferenceHelper>().typeAccount.then((value){
                                    print(value);
                                    if(value == KHACH_HANG){
                                      Get.toNamed(AppRoutes.V1_NOTIFICATION);
                                    }else if(value == THO_THAU){
                                      Get.toNamed(AppRoutes.V2_NOTIFICATION);
                                    }else if(value == DAI_LY){
                                      Get.toNamed(AppRoutes.V3_NOTIFICATION);
                                    }
                                  });
                                } else {
                                  Get.toNamed(notificationURL!);
                                }
                              },
                              child: Stack(
                                children: [
                                  const Icon(
                                    CupertinoIcons.bell_fill,
                                    color: Colors.white,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(1),
                                      width: Dimensions.MARGIN_SIZE_DEFAULT,
                                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                                      decoration: const BoxDecoration(
                                        color: ColorResources.RED,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            Dimensions
                                                .BORDER_RADIUS_EXTRA_LARGE,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        (soThongBao == null
                                                ? "0"
                                                : (soThongBao! > 9)
                                                    ? "+9"
                                                    : soThongBao)
                                            .toString(),
                                        style: const TextStyle(
                                          color: ColorResources.WHITE,
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
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
