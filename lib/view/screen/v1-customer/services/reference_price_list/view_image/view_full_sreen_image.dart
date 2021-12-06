import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/utils/images_path.dart';

class ViewFullScreenImage extends StatelessWidget {
  const ViewFullScreenImage({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: DeviceUtils.getScaledHeight(context,0.8),
              maxWidth: DeviceUtils.getScaledWidth(context,0.9),
            ),
            child: Hero(
              tag: image,
              child: PinchZoomImage(
                image: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, 
                    image: image,
                    fit: BoxFit.contain,
                    width: DeviceUtils.getScaledWidth(context,1),
                    height: DeviceUtils.getScaledHeight(context,1),
                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(Images.placeholder),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
