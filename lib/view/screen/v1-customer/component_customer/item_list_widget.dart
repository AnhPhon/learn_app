import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class ItemListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? subTitle;
  final String? rowText1;
  final String? rowText2;
  final String urlImage;
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
    required this.urlImage,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_SMALL,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        height: DeviceUtils.getScaledHeight(context, .13),
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
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: urlImage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
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
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                  if (subTitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      child: Text(
                        subTitle.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          color: ColorResources.GREY,
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
                        Row(
                          children: [
                            if (icon1 != null) icon1!,
                            if (isSpaceBetween == false)
                              const SizedBox(
                                  width: Dimensions.MARGIN_SIZE_SMALL),
                            if (rowText1 != null)
                              Text(
                                rowText1!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  color: colorRowText1,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            if (icon2 != null) icon2!,
                            if (isSpaceBetween == false)
                              const SizedBox(
                                  width: Dimensions.MARGIN_SIZE_SMALL),
                            if (rowText2 != null)
                              Text(
                                rowText2!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  color: colorRowText2,
                                ),
                              ),
                          ],
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
  }
}
