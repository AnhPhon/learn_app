import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
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
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
              color: Colors.grey.withOpacity(.5))
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context, .8),
        child: Text(
          label,
          style: const TextStyle(
            color: ColorResources.BLACKGREY,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    );
  }
}
