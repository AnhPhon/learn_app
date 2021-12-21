import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class FilterProduct extends StatefulWidget {
  const FilterProduct({Key? key}) : super(key: key);

  @override
  _FilterProdcutState createState() => _FilterProdcutState();
}

class _FilterProdcutState extends State<FilterProduct> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
        ),
        width: IZIDimensions.iziSize.width * 0.8,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    title(),
                    label(
                      lable: 'Danh mục',
                    ),
                    categoryCard(),
                    label(
                      lable: 'Thương hiệu',
                    ),
                    brandCard(),
                    label(
                      lable: 'Khoảng giá',
                    ),
                    rangeMoneyCard()
                  ],
                ),
              ),
            ),
            button()
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIText(
        text: "Bộ lọc tìm kiếm",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: IZIDimensions.FONT_SIZE_H5,
        ),
      ),
    );
  }

  Widget label({required String lable}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: IZIText(
        text: lable,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: IZIDimensions.FONT_SIZE_H6,
        ),
      ),
    );
  }

  Widget categoryCard() {
    return Column(
      children: [
        IZIListView(
          margin: EdgeInsets.only(
            top: IZIDimensions.SPACE_SIZE_4X,
          ),
          type: IZIListViewType.GRIDVIEW,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_3X,
          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 60,
          itemCount: 4,
          builder: (index) {
            return card(
              lable: "Sâm",
            );
          },
        ),
        moreButton(
          onTap: () {},
        ),
      ],
    );
  }
  Widget brandCard() {
    return Column(
      children: [
        IZIListView(
          margin: EdgeInsets.only(
            top: IZIDimensions.SPACE_SIZE_4X,
          ),
          type: IZIListViewType.GRIDVIEW,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_3X,
          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 60,
          itemCount: 4,
          builder: (index) {
            return card(
              lable: "Hùng Phong",
            );
          },
        ),
        moreButton(
          onTap: () {},
        ),
      ],
    );
  }
  Widget rangeMoneyCard() {
    return Column(
      children: [
        IZIListView(
          margin: EdgeInsets.only(
            top: IZIDimensions.SPACE_SIZE_4X,
          ),
          type: IZIListViewType.GRIDVIEW,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_3X,
          mainAxisExtent: '10.000 - 20.000'.length < 17 ? IZIDimensions.ONE_UNIT_SIZE * 60 : IZIDimensions.ONE_UNIT_SIZE * 80,
          itemCount: 4,
          builder: (index) {
            return card(
              lable: "10.000 - 20.000",
            );
          },
        ),
        moreButton(
          onTap: () {},
        ),
      ],
    );
  }

  Widget moreButton({required Function onTap}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                IZIText(
                  text: "Hiển thị nhiều hơn",
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget card({required String lable}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(
        IZIDimensions.BLUR_RADIUS_3X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.LIGHT_GREY.withOpacity(0.7),
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_2X,
        ),
      ),
      child: Text(
        lable,
      ),
    );
  }

  Widget button() {
    return Container(
      alignment: Alignment.center,
      height: IZIDimensions.ONE_UNIT_SIZE * 120,
      child: Center(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IZIButton(
                onTap: () {},
                width: IZIDimensions.ONE_UNIT_SIZE * 200,
                type: IZIButtonType.OUTLINE,
                label: 'Thiết lập lại',
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 14,
                ),
                borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                withBorder: 1,
              ),
              SizedBox(width: IZIDimensions.ONE_UNIT_SIZE * 10),
              IZIButton(
                onTap: () {},
                width: IZIDimensions.ONE_UNIT_SIZE * 200,
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 15,
                ),
                label: 'Áp dụng',
                borderRadius: IZIDimensions.BLUR_RADIUS_2X,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
