import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

import 'history_recruitment_news_controller.dart';

class SearchAppBarCardidate extends StatefulWidget
    implements PreferredSizeWidget {
  //: assert (onSwitch != null),assert(),

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<SearchAppBarCardidate> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V2HistoryRecruitmentNewsController(),
        builder: (V2HistoryRecruitmentNewsController controller) {
          return Container(
            color: ColorResources.APPBARCOLOR,
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: -70,
                  left: -25,
                  child: Container(
                    height: DeviceUtils.getScaledSize(context, 0.5),
                    width: DeviceUtils.getScaledSize(context, 0.4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                              ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                            ])),
                  ),
                ),
                Positioned(
                  top: -90,
                  right: -35,
                  child: Container(
                    height: DeviceUtils.getScaledSize(context, 0.5),
                    width: DeviceUtils.getScaledSize(context, 0.5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                              ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.2)
                            ])),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (controller.isSearch) {
                              controller.onChangedStatus();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorResources.WHITE,
                          )),

                      // Form tìm kiếm
                      if (controller.isSearch)
                        Expanded(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value,
                                child: TextField(
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (val) =>
                                        controller.onChangeTieuDe(context),
                                    keyboardType: TextInputType.text,
                                    textAlignVertical: TextAlignVertical.top,
                                    controller: controller.searchController,
                                    onChanged: (val) {},
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_SMALL,
                                                vertical: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .BORDER_RADIUS_EXTRA_SMALL),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                                  ColorResources.PRIMARYCOLOR),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .BORDER_RADIUS_EXTRA_SMALL),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                                  ColorResources.PRIMARYCOLOR),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .BORDER_RADIUS_EXTRA_SMALL),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color:
                                                  ColorResources.PRIMARYCOLOR),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .BORDER_RADIUS_EXTRA_SMALL),
                                        ),
                                        isDense: true,
                                        hintText: "Tìm kiếm",
                                        hintStyle: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(0.5),
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                        ),
                                        fillColor: ColorResources.WHITE,
                                        filled: true,
                                        suffixIcon: GestureDetector(
                                            onTap: () => controller
                                                .onChangeTieuDe(context),
                                            child: const Icon(Icons.search)))),
                              );
                            },
                          ),
                        ),
                      if (!controller.isSearch)
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_SMALL),
                              child: const Text(
                                'Tin đã lưu',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.WHITE),
                              )),
                        ),
                      const SizedBox(
                        width: Dimensions.ICON_SIZE_LARGE,
                      )
                    ],
                  ),
                ),
                // Nút tìm kiếm

                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (controller.isSearch)
                          const SizedBox(
                            width: Dimensions.ICON_SIZE_DEFAULT,
                          )
                        else
                          IconButton(
                              onPressed: () {
                                controller.onChangedStatus();
                              },
                              icon: const Icon(
                                Icons.search,
                                size: Dimensions.ICON_SIZE_DEFAULT,
                                color: ColorResources.WHITE,
                              )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
