

import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';

class RecruimentNewsCard extends StatelessWidget {
  const RecruimentNewsCard({ Key? key, required this.index }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL
      ),
      child: BoxShadowWidget(
        child: SizedBox(
          height: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      child: Image.asset(
                        Images.newsTemplate,
                        fit: BoxFit.cover,
                        height: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
                      ),
                    ),
                    const Text("Đà Nẵng", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                      shadows: boxShadowText
                    ),)
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text("Cần tuyển 2 nhân viên kiến trúc" , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                        )),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: ColorResources.GREY,
                                fontWeight: FontWeight.w500
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Lương thoã thuận"),
                                  if (index % 2 == 0) 
                                  const Text("Tin chưa duyệt", overflow: TextOverflow.ellipsis,style: TextStyle(
                                    color: ColorResources.RED
                                  ),) 
                                  else 
                                  const Text("Tin đã duyệt", overflow: TextOverflow.ellipsis,style: TextStyle(
                                    color: ColorResources.GREEN,
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}