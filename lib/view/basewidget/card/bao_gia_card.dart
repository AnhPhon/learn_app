import 'package:flutter/cupertino.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/text/text_white_border.dart';

class BaoGiaCard extends StatelessWidget {
  String donHangName;
  String donHangId;
  String time;
  String date;
  String label;
  String content;
  String locationName;

  BaoGiaCard({
    required this.donHangName,
    required this.donHangId,
    required this.time,
    required this.date,
    required this.label,
    required this.content,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 80,
          child: Stack(
            children: [
              Image.network(Images.location_example, fit: BoxFit.fill),
              Positioned(child: TextWhiteBorder(text: locationName))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Column(
            children: [
              Text(
                donHangName,
                style: Dimensions.textTitleStyleCard(),
              ),
              Row(
                children: [
                  Text(
                    donHangId,
                    style: Dimensions.textNormalStyleCard(),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        time,
                        style: Dimensions.textNormalStyleCard(),
                      ),
                      Text(
                        date,
                        style: Dimensions.textNormalStyleCard(),
                      ),
                    ],
                  ),
                  Text(
                    "$label: $content",
                    style: Dimensions.textNormalStyleCard(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
