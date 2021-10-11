import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'TitilliumWeb',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

const titilliumSemiBold = TextStyle(
  fontFamily: 'TitilliumWeb',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w600,
);

const titilliumBold = TextStyle(
  fontFamily: 'TitilliumWeb',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);
const titilliumItalic = TextStyle(
  fontFamily: 'TitilliumWeb',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontStyle: FontStyle.italic,
);

const robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

const robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);

const boxShadow =[
  BoxShadow(
    color: ColorResources.LIGHT_BLACK,
    blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
    spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM
  )
];
const boxShadowMedium = [
  BoxShadow(
    //offset: Offset(0, -1),
    blurRadius: Dimensions.BLUR_RADIUS_MEDIUM,
    spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM,
    color: ColorResources.LIGHT_BLACK
  ),
];
const boxShadowDeep = [
  BoxShadow(
    //offset: Offset(0, -1),
    blurRadius: Dimensions.BLUR_RADIUS_DEEP,
    spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM_DEEP,
    color: ColorResources.LIGHT_BLACK
  ),
];

const boxShadowText = [
    BoxShadow(
      blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
      color: ColorResources.WHITE,
      spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM,
      offset: Offset(-1,1)
    ),
    BoxShadow(
      blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
      color: ColorResources.WHITE,
      spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM,
      offset: Offset(1,-1)
    ),
    BoxShadow(
      blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
      color: ColorResources.WHITE,
      spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM,
      offset: Offset(1,1)
    ),
    BoxShadow(
      blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
      color: ColorResources.WHITE,
      spreadRadius: Dimensions.SPREAD_RADIUS_MEDIUM,
      offset: Offset(-1,-1)
    )
];

const paddingSmall =  EdgeInsets.all(Dimensions.FONT_SIZE_SMALL);
