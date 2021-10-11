import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class FileUploadWidget extends StatelessWidget {
  final String label;
  const FileUploadWidget({required this.label});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
          ),
          boxShadow: [
            BoxShadow(blurRadius: Dimensions.BLUR_RADIUS_LIGHT, color: Colors.grey.withOpacity(.5))
          ]),
      child: Text(label, style: Dimensions.textTitleStyleCard()),
    );
  }
}
