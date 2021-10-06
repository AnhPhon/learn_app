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

var boxShadow =[
      BoxShadow(
        color: ColorResources.BLACK.withOpacity(0.3),
        blurRadius: 5,
        spreadRadius: 0.4
      )
    ];

//  [
//   BoxShadow(
//     color: ColorResources.BLACK.withOpacity(0.1),
//     blurRadius: 1,
//     spreadRadius: 0.1
//   )
// ];

const paddingSmall =  EdgeInsets.all(Dimensions.FONT_SIZE_SMALL);
