import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';

class BaoGiaCard extends StatelessWidget {
  final String donHangName;
  final String donHangId;
  final String time;
  final String date;
  final String label;
  final String content;
  final String locationName;
  final String image;
  final double? fontSize;
  final Function() onTap;

  const BaoGiaCard({
    required this.donHangName,
    required this.donHangId,
    required this.time,
    required this.date,
    required this.label,
    required this.content,
    required this.locationName,
    required this.image,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_SMALL,
        ),
        height: DeviceUtils.getScaledHeight(context, .15),
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
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        donHangName,
                        maxLines: 2,
                        style: Dimensions.textTitleStyleCard(),
                      ),
                    ),
                    Row(
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
                    const SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text(
                      content,
                      style: fontSize == null
                          ? Dimensions.textNormalStyleCard()
                          : TextStyle(
                              fontSize: fontSize,
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
