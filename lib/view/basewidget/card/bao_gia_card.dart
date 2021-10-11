import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/text/text_white_border.dart';

class BaoGiaCard extends StatelessWidget {
  String donHangName;
  String donHangId;
  String time;
  String date;
  String label;
  String content;
  String locationName;
  String image;
  Function() onTap;

  BaoGiaCard({
    required this.donHangName,
    required this.donHangId,
    required this.time,
    required this.date,
    required this.label,
    required this.content,
    required this.locationName,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_SMALL,
          vertical: Dimensions.MARGIN_SIZE_SMALL,
        ),
        height: DeviceUtils.getScaledHeight(context, .18),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
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
                child: FadeInImage.assetNetwork(
                  placeholder: Images.toolbar_background,
                  image: image,
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        child: Text(
                          donHangName,
                          maxLines: 2,
                          style: Dimensions.textTitleStyleCard(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              donHangId,
                              textAlign: TextAlign.center,
                              style: Dimensions.textNormalStyleCard(),
                            ),
                          ),
                          Text(
                            "$time $date",
                            style: Dimensions.textNormalStyleCard(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      child: Text(
                        "Thợ ốp lát: Công trình khách 5 sao",
                        style: Dimensions.textNormalStyleCard(),
                      ),
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
