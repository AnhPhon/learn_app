import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';

enum IZIListViewType { LISTVIEW, GRIDVIEW }

class IZIListView extends StatelessWidget {
  IZIListView({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.type = IZIListViewType.LISTVIEW,
    this.label,
    this.action,
    this.crossAxisCount = 2,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.childAspectRatio = 1,
    this.mainAxisExtent,
    this.physics = const NeverScrollableScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    this.height,
    this.margin = 0,
  }) : super(key: key);

  final IZIListViewType type;
  // final List<dynamic> data;
  final int itemCount;
  final String? label;
  final Widget? action;
  final int? crossAxisCount;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final double? childAspectRatio;
  final double? mainAxisExtent;
  final Axis? scrollDirection;
  final ScrollPhysics? physics;
  final Widget Function(int index) builder;
  final double? height, margin;

  Widget getListView(IZIListViewType type) {
    if (type == IZIListViewType.GRIDVIEW) {
      return GridView.builder(
        scrollDirection: scrollDirection!,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount!,
          crossAxisSpacing: crossAxisSpacing ?? IZIDimensions.ONE_UNIT_SIZE * 20,
          mainAxisSpacing: mainAxisSpacing ?? IZIDimensions.ONE_UNIT_SIZE * 5,
          childAspectRatio: mainAxisExtent ?? childAspectRatio!,
          mainAxisExtent: mainAxisExtent ?? IZIDimensions.ONE_UNIT_SIZE * 400,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return builder(index);
        },
      );
    }
    return ListView.builder(
      scrollDirection: scrollDirection!,
      shrinkWrap: true,
      itemCount: itemCount,
      physics: physics, //const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return builder(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!IZIValidate.nullOrEmpty(label))
                IZIText(
                  text: label.toString(),
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              action ?? const SizedBox(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: margin!
            ),
            height: scrollDirection == Axis.horizontal ? height ?? IZIDimensions.ONE_UNIT_SIZE * 180 + margin! : null,
            child: getListView(type),
          )
        ],
      ),
    );
  }
}
