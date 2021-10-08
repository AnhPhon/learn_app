import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class ItemListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? rowText1;
  final String? rowText2;
  final Color? colorRowText1;
  final Color? colorRowText2;
  final Icon? icon1;
  final Icon? icon2;
  final bool? isSpaceBetween;
  final bool? isStart;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_SMALL,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        height: DeviceUtils.getScaledHeight(context, .118),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: [
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
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                ),
                child: Image.asset(
                  Images.newsTemplate,
                  fit: BoxFit.fill,
                  height: DeviceUtils.getScaledHeight(context, 0.118),
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Row(
                      mainAxisAlignment: isSpaceBetween == true
                          ? MainAxisAlignment.spaceBetween
                          : isStart == true
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      children: [
                        if (icon1 != null) icon1!,
                        if (isSpaceBetween == false)
                          const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL),
                        if (rowText1 != null)
                          Flexible(
                            child: Text(
                              rowText1!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: colorRowText1,
                              ),
                            ),
                          ),
                        if (icon2 != null) icon2!,
                        if (rowText2 != null)
                          Text(
                            rowText2!,
                            style: TextStyle(
                                color: colorRowText2,
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
