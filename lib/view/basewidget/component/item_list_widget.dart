import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class ItemListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? subTitle;
  final String? rowText1;
  final String? rowText2;
  final String urlImage;
  final Color? colorRowText1;
  final Color? colorRowText2;
  final Color? colorSubTitle;
  final Icon? iconSubTitle;
  final Icon? icon1;
  final Icon? icon2;
  final bool? isSpaceBetween;
  final bool? isStart;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;

  const ItemListWidget({
    Key? key,
    required this.title,
    this.rowText1,
    this.rowText2,
    this.colorRowText1,
    this.colorRowText2,
    required this.onTap,
    this.isSpaceBetween = false,
    this.isStart,
    this.icon1,
    this.icon2,
    required this.urlImage,
    this.subTitle,
    this.padding,
    this.margin,
    this.colorSubTitle,
    this.iconSubTitle,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ??
            const EdgeInsets.symmetric(
              vertical: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 0,
            ),
        height: DeviceUtils.getScaledHeight(context, .14),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 2)),
              ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                  ),
                  child: FadeInImageCustom(
                    urlImage: urlImage,
                    height: double.infinity,
                    width: double.infinity,
                  )),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL,
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          ),
                        ),
                        if (subTitle != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (iconSubTitle != null) iconSubTitle!,
                              if (iconSubTitle != null && subTitle != null)
                                const SizedBox(
                                  width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),
                              Flexible(
                                child: Text(
                                  subTitle.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    color: colorSubTitle ?? ColorResources.GREY,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: isSpaceBetween == true
                          ? MainAxisAlignment.spaceBetween
                          : isStart == true
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        if (icon1 != null || rowText1 != null)
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (icon1 != null) icon1!,
                                if (icon1 != null && rowText1 != null)
                                  const SizedBox(
                                    width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                if (rowText1 != null)
                                  Flexible(
                                    child: Text(
                                      rowText1!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        color: colorRowText1,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (icon2 != null || rowText2 != null)
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: (isSpaceBetween == true)
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (icon2 != null) icon2!,
                                if (icon2 != null && rowText2 != null)
                                  const SizedBox(
                                    width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                  ),
                                if (rowText2 != null)
                                  Flexible(
                                    child: Text(
                                      rowText2!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: colorRowText2,
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                const SizedBox(
                                  width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
