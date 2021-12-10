import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class IZIOtp extends StatelessWidget {
  const IZIOtp({
    Key? key,
    this.lable,
    this.content,
    this.onTap,
    this.onTapSendSMS,
    this.colorLable,
  }) : super(key: key);
  final String? lable;
  final String? content;
  final Function? onTap;
  final Function? onTapSendSMS;
  final Color? colorLable;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: IZIDimensions.ONE_UNIT_SIZE * 15,
            sigmaY: IZIDimensions.ONE_UNIT_SIZE * 15,
          ),
          child: Container(
            width: IZIDimensions.ONE_UNIT_SIZE * 500,
            height: IZIDimensions.ONE_UNIT_SIZE * 700,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  IZIDimensions.BORDER_RADIUS_7X,
                ),
                bottomRight: Radius.circular(
                  IZIDimensions.BORDER_RADIUS_7X,
                ),
              ),
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            child: Column(
              children: [
                if (!IZIValidate.nullOrEmpty(lable))
                  Container(
                    margin: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_5X,
                    ),
                    child: IZIText(
                      text: lable!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: IZIDimensions.FONT_SIZE_H4,
                        color: colorLable ?? ColorResources.CIRCLE_COLOR_BG3,
                      ),
                    ),
                  ),
                if (!IZIValidate.nullOrEmpty(content))
                  Container(
                    margin: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: IZIText(
                        text: content!,
                        textAlign: TextAlign.center,
                        maxLine: 4,
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        )),
                  ),
                IZIButton(
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
