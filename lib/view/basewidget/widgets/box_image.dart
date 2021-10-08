
import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/image_card.dart';

class BoxImage extends StatelessWidget {
  const BoxImage({
    Key? key,
    this.isAddImage = false,
    this.onPress,
    required this.images,
  }) : super(key: key);
  final bool? isAddImage;
  final Function()? onPress;
  final List<Widget> images;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          width: DeviceUtils.getScaledWidth(context,1),
          height: 120,
          decoration: BoxDecoration(
            color: ColorResources.GREY.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            border: Border.all(color: ColorResources.PRIMARYCOLOR)
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, //images.length + 1
            itemBuilder: (context, index) {
              if(isAddImage!){
                if(index == 2){ // == images.length
                  return Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.PRIMARYCOLOR.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
                      ),
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: IconButton(onPressed: onPress, icon: const Icon(
                          Icons.add,
                          size: Dimensions.ICON_SIZE_LARGE,
                          color: ColorResources.BLACK,
                        )
                      ),
                    ),
                  ));
                }
                return ImageCard(image: Images.admin_background, isAddImage: isAddImage!,);
              }else{
                return ImageCard(image: Images.admin_background, isAddImage: isAddImage!);
              }
            },
          ),
        ),
      ],
    );
  }
}
