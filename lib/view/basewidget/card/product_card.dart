import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class ProductCard extends StatelessWidget {
  String title;
  String image;
  String cost;

  ProductCard({
    required this.title,
    required this.image,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10,
            offset: const Offset(0, -10)
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))
      ),
      child: Column(
        children: [
          SizedBox(
            // height: 160,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
              child: Image.network(image),
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0xff242425),
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cost,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
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
