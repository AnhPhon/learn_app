


import 'package:flutter/material.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard({
    Key? key,
    this.showEmailAndPass = true,
  }) : super(key: key);
  final bool ? showEmailAndPass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: BoxShadowWidget(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextHighlight(title: "Tiêu đề: ", content: "Kiến trúc sư tại Đà Nẵng, Quảng Nam"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: Image.asset(
                          Images.admin_background,
                          height: Dimensions.AVATAR_SQUARE_SIZE_EXTRA_LARGE,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text("MSHS: 123456789", style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextHighlight(title: "Tên: ", content: "Đỗ Thanh Huy"),
                        const TextHighlight(title: "Ngày sinh: ", content: "25/08/1997"),
                        TextHighlight(title: "Điện thoại: ", content: showEmailAndPass! ? "0353932341" : "*********"),
                        const TextHighlight(title: "Kinh nghiệm: ", content: "2 năm"),
                        TextHighlight(title: "Email: ", content: showEmailAndPass! ?  "dothanhhuy@gmail.com" : "*************"),
                        const TextHighlight(title: "Chỗ ở hiện tại: ", content: "51 Tố Hữu Đà Nẵng, Quảng Nam"),
                        const TextHighlight(title: "Hôn nhân: ", content: "Độc thân"),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
