import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/contract_list/list_of_interest_payments/list_of_interest_payments_controller.dart';

class ListOfInterestPaymentsPage extends GetView<ListOfInterestPaymentsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Quản lý tài khoản",
      ),
      body: GetBuilder(
          init: ListOfInterestPaymentsController(),
          builder: (ListOfInterestPaymentsController controller) {
            return Container(
              constraints: BoxConstraints(
                minWidth: IZIDimensions.iziSize.width,
                minHeight: IZIDimensions.iziSize.height,
              ),
              color: ColorResources.BACKGROUND,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_3X,
                      ),
                      boxShadow: IZIOther().boxShadow,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                      vertical: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                      vertical: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Số tiền phụ thêm :",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "30.000 đ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w600,
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
                                child: Text(
                                  "Số tiền lãi :",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "120.000 đ",
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w600,
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
                          children: [
                            Expanded(
                              child: Text(
                                "Số tiền thực lãnh :",
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "150.000 đ",
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
