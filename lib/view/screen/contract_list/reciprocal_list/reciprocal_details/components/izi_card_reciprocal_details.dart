import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';

enum IZITypeReciprocalDetails {
  DA_SU_DUNG,
  DA_DUYET,
  CHUA_DUYET,
}

class IZICardReciprocalDetails extends StatelessWidget {
  IZICardReciprocalDetails({
    Key? key,
    required this.sanPham,
    required this.soLuong,
    required this.giaTien,
    required this.tongTien,
    required this.type,
  }) : super(key: key);

  final String sanPham;
  final String soLuong;
  final String giaTien;
  final String tongTien;
  IZITypeReciprocalDetails type;

  Widget getIZITypeReciprocalDetails(IZITypeReciprocalDetails type) {
    if (type == IZITypeReciprocalDetails.DA_SU_DUNG) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_3X,
        ),
        decoration: BoxDecoration(
          color: ColorResources.ORDER_HUY_DON,
          borderRadius: BorderRadius.circular(
            IZIDimensions.BLUR_RADIUS_1X,
          ),
        ),
        child: Text(
          "Đã sử dụng",
          style: TextStyle(
            color: ColorResources.LABEL_ORDER_HUY_DON,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
          ),
        ),
      );
    } else if (type == IZITypeReciprocalDetails.CHUA_DUYET) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_3X,
        ),
        decoration: BoxDecoration(
          color: ColorResources.ORDER_DA_GIAO,
          borderRadius: BorderRadius.circular(
            IZIDimensions.BLUR_RADIUS_1X,
          ),
        ),
        child: Text(
          "Chưa duyệt",
          style: TextStyle(
            color: ColorResources.LABEL_ORDER_DA_GIAO,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
          ),
        ),
      );
    } else if (type == IZITypeReciprocalDetails.DA_DUYET) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_3X,
        ),
        decoration: BoxDecoration(
          color: ColorResources.ORDER_XAC_NHAN,
          borderRadius: BorderRadius.circular(
            IZIDimensions.BLUR_RADIUS_1X,
          ),
        ),
        child: Text(
          "Đã duyệt",
          style: TextStyle(
            color: ColorResources.LABEL_ORDER_XAC_NHAN,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
          ),
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_3X,
        horizontal: IZIDimensions.SPACE_SIZE_3X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Sản phẩm :",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    sanPham,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Số lượng : ",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    soLuong,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Giá tiền : ",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    giaTien,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Tổng tiền : ",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    tongTien,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getIZITypeReciprocalDetails(type),
            ],
          ),
        ],
      ),
    );
  }
}
