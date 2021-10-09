import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class AddIndentityCard extends StatelessWidget {
  const AddIndentityCard({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.16),
      width: DeviceUtils.getScaledWidth(context, 0.38),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_EXTRA_SMALL,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorResources.BLACK.withAlpha(40),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_photo_alternate_outlined,
              size: Dimensions.ICON_SIZE_EXTRA_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Text(
            label,
            style: Dimensions.fontSizeStyle16w600(),
          ),
        ],
      ),
    );
  }
}
