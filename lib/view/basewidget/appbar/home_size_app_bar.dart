import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String fullname;
  final String image;
  final bool? centerTitle;
  final List<Widget>? action;
  const HomeAppBar({
    Key? key,
    required this.fullname,
    required this.image,
    this.centerTitle = true,
    this.action = const [],
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final String fullname = widget.fullname;

    return Container(
      color: ColorResources.APPBARCOLOR,
      height: DeviceUtils.getScaledHeight(context, 1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -235,
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
                    ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -150,
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
                    ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, 1),
            padding: const EdgeInsets.only(
                // left: width / 2 - title.length/2*5,
                ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                  ),
                  padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                  margin: const EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                    child: Image.asset(
                      widget.image,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(
                //         Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                //   ),
                //   padding: const EdgeInsets.all(2),
                //   margin: const EdgeInsets.only(right: 10),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(
                //         Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                //     child: Image.asset(
                //       widget.image,
                //       width: 40,
                //       height: 40,
                //     ),
                //   ),
                // ), -----> For API

                Text(
                  "Hi, $fullname!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
