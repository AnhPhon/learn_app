import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';

class CartHomePage extends StatelessWidget {
  final VoidCallback getToNamed;
  final int quanlity;
  const CartHomePage(
      {Key? key, required this.getToNamed, required this.quanlity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getToNamed,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),

        ///icon cart
        child: Stack(
          children: [
            Container(
              height: DeviceUtils.getScaledHeight(context, .035),
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_EXTRA_SMALL - 2,
              ),
              margin: const EdgeInsets.only(
                right: Dimensions.MARGIN_SIZE_EXTRA_SMALL + 2,
              ),
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    width: 1.5,
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
              child: Image.asset(
                Images.cart,
                color: ColorResources.WHITE,
              ),
            ),

            ///quanlity
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: DeviceUtils.getScaledHeight(context, .02),
                width: DeviceUtils.getScaledWidth(context, .04),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.RED,
                ),
                child: Text(
                  quanlity.toString(),
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
