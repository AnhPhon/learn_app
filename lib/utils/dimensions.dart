import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_EXTRA_SUPER_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 22.0;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;

  static const double MARGIN_SIZE_EXTRA_SMALL = 5.0;
  static const double MARGIN_SIZE_SMALL = 10.0;
  static const double MARGIN_SIZE_DEFAULT = 15.0;
  static const double MARGIN_SIZE_LARGE = 20.0;
  static const double MARGIN_SIZE_EXTRA_LARGE = 25.0;

  static const double ICON_SIZE_EXTRA_SMALL = 12.0;
  static const double ICON_SIZE_SMALL = 18.0;
  static const double ICON_SIZE_DEFAULT = 24.0;
  static const double ICON_SIZE_LARGE = 32.0;
  static const double ICON_SIZE_EXTRA_LARGE = 40.0;

  static const double SPACE_WIDTH_SMALL = 5.0;
  static const double SPACE_WIDTH_DEFAULT = 10.0;
  static const double SPACE_WIDTH_FAR = 50.0;

  static const double CATEGORY_WIDTH_DEFAULT = 70.0;

  static const double SPACE_HEIGHT_SMALL = 5.0;
  static const double SPACE_HEIGHT_DEFAULT = 10.0;

  static const double SQUARE_CATEGORY_SIZE = 170.0;

  // BORDER RADIUS
  static const double BORDER_RADIUS_EXTRA_SMALL = 5.0;
  static const double BORDER_RADIUS_SMALL = 7.0;
  static const double BORDER_RADIUS_DEFAULT = 10.0;
  static const double BORDER_RADIUS_BIG = 25;
  static const double BORDER_RADIUS_LARGE = 30.0;
  static const double BORDER_RADIUS_EXTRA_LARGE = 50.0;

  // AVATAR
  static const double AVATAR_SQUARE_SIZE_EXTRA_SMALL = 25;
  static const double AVATAR_SQUARE_SIZE_SMALL = 50;
  static const double AVATAR_SQUARE_SIZE_DEFAULT = 100;
  static const double AVATAR_SQUARE_SIZE_LARGE = 150;
  static const double AVATAR_SQUARE_SIZE_EXTRA_LARGE = 200;
  //BLUR RADIUS
  static const double BLUR_RADIUS_LIGHT = 5;
  static const double BLUR_RADIUS_MEDIUM = 10;
  static const double BLUR_RADIUS_DEEP = 15;
  //spread Radius
  static const double SPREAD_RADIUS_LIGHT = 0.2;
  static const double SPREAD_RADIUS_MEDIUM = 0.4;
  static const double SPREAD_RADIUS_DEEP = 0.6;
  static const double SPREAD_RADIUS_MEDIUM_DEEP = 1;
  static const double SPREAD_RADIUS_VERY_DEEP = 2;

  // SCALE
  static const double SCALE_EXTRA_SMALL = .005;
  static const double SCALE_SMALL = .01;
  static const double SCALE_DEFAULT = .02;
  static const double SCALE_LARGE = .03;
  static const double SCALE_EXTRA_LARGE = .04;

  // RADIUS
  static const double HOME_BORDER_RADIUS = 30;

  // COLOR
  static const int COLOR_LABEL_DEFAULT = 0xff2A3547;

  // CARD
  static const int TEXT_TITLE_COLOR = 0XFF474747;
  static const int TEXT_NORMAL_COLOR = 0XFF5A5757;
  static const int TEXT_NORMAL_GREY_COLOR = 0XFF8B8B8B;

  static TextStyle textTitleStyleCard() {
    return const TextStyle(
      color: Color(TEXT_TITLE_COLOR),
      fontSize: FONT_SIZE_EXTRA_LARGE,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle textNormalStyleCard() {
    return const TextStyle(
      color: Color(TEXT_NORMAL_COLOR),
      fontSize: FONT_SIZE_DEFAULT,
    );
  }

  static TextStyle textNormalGreyStyleCard() {
    return const TextStyle(
      color: Color(TEXT_NORMAL_GREY_COLOR),
      fontSize: FONT_SIZE_DEFAULT,
    );
  }

  static TextStyle textTitleStyle() {
    return const TextStyle(
      color: Color(TEXT_TITLE_COLOR),
      fontSize: FONT_SIZE_EXTRA_LARGE,
    );
  }

  static TextStyle textNormalStyle() {
    return const TextStyle(
      color: Color(TEXT_NORMAL_COLOR),
      fontSize: FONT_SIZE_EXTRA_LARGE,
    );
  }

  static TextStyle textInputNormalStyle() {
    return const TextStyle(
      color: ColorResources.RED,
      fontSize: FONT_SIZE_EXTRA_LARGE,
    );
  }

  // SIZE BOX BOTTOM NAV
  static const double SIZE_BOX_BOTTOM_NAV = 150;

  Widget paddingDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledSize(context, 0.02),
      ),
      child: const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  static TextStyle fontSizeStyle20() {
    return const TextStyle(fontSize: 20);
  }

  static TextStyle fontSizeStyle18() {
    return const TextStyle(fontSize: 18);
  }

  static TextStyle fontSizeStyle16() {
    return const TextStyle(fontSize: 16);
  }

  static TextStyle fontSizeStyle14() {
    return const TextStyle(fontSize: 14);
  }

  static TextStyle fontSizeStyle12() {
    return const TextStyle(fontSize: 12);
  }

  static TextStyle fontSizeStyle20w600() {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle22w600() {
    return const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle18w600() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle16w600() {
    return const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle14w600() {
    return const TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT, fontWeight: FontWeight.w600);
  }

  static TextStyle fontSizeStyle12w600() {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  }
}
