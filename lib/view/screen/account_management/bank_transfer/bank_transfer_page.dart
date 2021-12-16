import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account_management/bank_transfer/bank_transfer_controller.dart';

class BankStansferPage extends GetView<BankTransferController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back(
              result: true,
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Chuyển khoản ngân hàng",
      ),
      body: GetBuilder(
        init: BankTransferController(),
        builder: (BankTransferController controller) {
          return Container(
            color: ColorResources.BACKGROUND,
            constraints: BoxConstraints(
              maxWidth: IZIDimensions.iziSize.width,
              minHeight: IZIDimensions.iziSize.height,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
              vertical: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông tin tài khoản",
                  style: TextStyle(
                    color: ColorResources.BLACK,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //Thông tin tài khoản chuyển khoản
                _transferAccountInformation(controller),

                //Nội dung chuyển khoản
                _transferContents(controller),

                //Hình ảnh giao dịch
                _transactionPictures(),
              ],
            ),
          );
        },
      ),
      widgetBottomSheet: //Button xác nhận
          Container(
        color: ColorResources.BACKGROUND,
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: IZIButton(
          onTap: () {
            controller.goToTransactionConfirmation();
          },
          label: "Xác nhận",
        ),
      ),
    );
  }

  ///
  ///Hình ảnh giao dịch
  ///
  Widget _transactionPictures() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          Text(
            'Hình ảnh giao dịch của bạn',
            style: TextStyle(
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H6,
            ),
          ),
          IZIFile(
            height: IZIDimensions.ONE_UNIT_SIZE * 230,
            width: IZIDimensions.ONE_UNIT_SIZE * 230,
            onPikerFile: (value) {},
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_5X * 2,
            ),
            child: Text(
              "Chụp màn hình giao dịch để cập nhật thông tin nhanh hơn",
              style: TextStyle(
                color: ColorResources.RED,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///Nội dung chuyển khoản
  ///
  Widget _transferContents(BankTransferController controller) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_3X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        boxShadow: IZIOther().boxShadow,
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Nội dung chuyển khoản (bắt buộc)",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    controller.contentTransfer,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.onBtnCopyContentTransfer(
                    content: controller.contentTransfer,
                  );
                },
                child: const Icon(Icons.copy),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              IZIDimensions.SPACE_SIZE_2X,
              IZIDimensions.SPACE_SIZE_2X,
              IZIDimensions.SPACE_SIZE_2X,
              0,
            ),
            child: Text(
              "Vui lòng điền đúng nội dung chuyển khoản, nếu có sai sót chúng tôi sẽ không chịu trách nhiệm ",
              style: TextStyle(
                color: ColorResources.RED,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  ///
  ///Thông tin tài khoản chuyển khoản
  ///
  Widget _transferAccountInformation(BankTransferController controller) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Ngân hàng nhận",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Techcombank",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Số tài khoản",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.accountNumber,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onBtnCopyAccountNumber(
                              content: controller.accountNumber,
                            );
                          },
                          child: const Icon(Icons.copy),
                        )
                      ],
                    ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Tên tài khoản",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Công ty Hà Nội Safe Food",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
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
              bottom: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Số tiền ",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "100.000đ",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.CIRCLE_COLOR_BG,
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
        ],
      ),
    );
  }
}
