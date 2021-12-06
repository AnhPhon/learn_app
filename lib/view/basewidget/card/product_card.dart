import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/dimensions.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final String cost;

  const ProductCard({
    required this.title,
    required this.image,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimensions.BORDER_RADIUS_DEFAULT,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                ),
                child: (image.isEmpty || image == 'null')
                    ? Image.asset(
                        'assets/images/placeholder.jpg',
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: image,
                        image: image,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Container(
            height: 85,
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
                const SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$cost VND",
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
