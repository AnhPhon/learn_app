import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class KhoSanPham extends StatelessWidget {
  final String tenSanPham;
  final String maSanPham;
  final String giaSanPham;
  final String quyCach;

  const KhoSanPham({
    required this.tenSanPham,
    required this.maSanPham,
    required this.giaSanPham,
    required this.quyCach,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: DeviceUtils.getScaledWidth(context, 1),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(.2),
            blurRadius: 5,
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        ),
      ),
      margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
      child: Row(
        children: <Widget>[
          Container(
            width: DeviceUtils.getScaledWidth(context, .2),
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
              ),
              image: DecorationImage(
                image: AssetImage(Images.V4NewsExample),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            width: DeviceUtils.getScaledWidth(context, .7),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tenSanPham,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 53, 71, 1),
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Mã: $maSanPham",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        giaSanPham,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        "Quy cách:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        quyCach,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
