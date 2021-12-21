import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class IZIOther {
  ///
  /// open link url
  ///
  static Future openLink({required String url}) async {
    if (!IZIValidate.nullOrEmpty(url)) {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  static String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(0, -2),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
    BoxShadow(
      offset: const Offset(-2, 0),
      blurRadius: IZIDimensions.BLUR_RADIUS_4X,
      color: ColorResources.BLACK.withAlpha(10),
    ),
  ];
}
