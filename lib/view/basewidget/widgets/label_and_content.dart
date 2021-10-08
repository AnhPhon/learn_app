import 'package:flutter/cupertino.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelContent extends StatelessWidget {
  String title;
  Widget content;
  bool isRequired;
  LabelContent(
      {required this.title, required this.content, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // địa điểm nhận
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(title, style: Dimensions.textTitleStyleCard()),
              if (isRequired == true)
                const Text(
                  "*",
                  style: TextStyle(
                    color: ColorResources.RED,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          height:
              DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT),
        ),
        // content
        content,
      ],
    );
  }
}
