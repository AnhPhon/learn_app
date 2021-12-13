import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_tabview.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZITabBar<T> extends StatelessWidget {
  const IZITabBar({
    Key? key,
    required this.items,
    required this.onTapChangedTabbar,
    this.currentIndex = 0,
    this.onTap,
    this.heightTabView,
    this.widthTabBar,
    this.heightTabBar,
    this.colorTabBar,
    this.radiusTabBar,
    this.isUnderLine = true,
    this.colorText,
  }) : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabbar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final double? radiusTabBar;
  final bool? isUnderLine;
  final double? heightTabBar;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightTabBar ?? IZIDimensions.ONE_UNIT_SIZE * 60,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          radiusTabBar ?? 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                onTapChangedTabbar(index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 10,
                  vertical: IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                height: double.infinity,
                width: widthTabBar != null ? (widthTabBar!.roundToDouble() / (items.length + .5)) : IZIDimensions.ONE_UNIT_SIZE * 580.roundToDouble() / (items.length + .5),
                decoration: BoxDecoration(
                  color: colorTabBar ?? ColorResources.WHITE,
                  borderRadius: !isUnderLine!
                      ? BorderRadius.circular(
                          radiusTabBar ?? IZIDimensions.BLUR_RADIUS_3X,
                        )
                      : null,
                  border: isUnderLine!
                      ? Border(
                          bottom: currentIndex == index
                              ? BorderSide(
                                  width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                  color: ColorResources.MY_ORDER_LABEL,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    items[index].toString(),
                    style: TextStyle(
                      color: currentIndex == index ? colorText ?? ColorResources.MY_ORDER_LABEL : ColorResources.GREY,
                      fontWeight: currentIndex == index ? FontWeight.w600 : FontWeight.normal,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
