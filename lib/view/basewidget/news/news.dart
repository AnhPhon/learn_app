import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class NewsBox extends StatelessWidget {
  final String title;
  final String describe;

  const NewsBox({
    required this.title,
    required this.describe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(.2),
            blurRadius: 5,
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
      padding: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_EXTRA_SMALL, right: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
              ),
              image: DecorationImage(
                image: AssetImage(Images.V4NewsExample),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            width: 240,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 53, 71, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    describe,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.62),
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
