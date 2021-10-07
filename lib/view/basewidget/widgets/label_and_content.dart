import 'package:flutter/cupertino.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelContent extends StatelessWidget {
  String title;
  Widget content;
  LabelContent({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // địa điểm nhận
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Dimensions.textTitleStyleCard(),
          ),
        ),
        SizedBox(height: DeviceUtils.getScaledHeight(context, .02),),
        // content
        content,
      ],
    );
  }
}
