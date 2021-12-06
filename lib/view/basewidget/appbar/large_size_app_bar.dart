import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';

class LargeSizeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final List<Widget>? action;
  const LargeSizeAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.action = const [],
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<LargeSizeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.APPBARCOLOR,
      height: DeviceUtils.getScaledHeight(context, 1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -145,
            left: -25,
            child: Container(
              height: 370,
              width: 200,
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
            top: -60,
            right: -60,
            child: Container(
              height: 220,
              width: 220,
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
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: Dimensions.MARGIN_SIZE_DEFAULT * 2,
          //     top: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
          //   ),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: const [
          //       CircleAvatar(
          //         radius: 30,
          //       ),
          //       Text("Name")
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
