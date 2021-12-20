import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_details/components/izi_card_reciprocal_details.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_details/reciprocal_details_controller.dart';

class ReciprocalDetailsPage extends GetView<ReciprocalDetailsController> {
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
        title: "Chi tiết đối ứng",
      ),
      body: GetBuilder(
        init: ReciprocalDetailsController(),
        builder: (ReciprocalDetailsController controller) {
          return Container(
            constraints: BoxConstraints(
              minWidth: IZIDimensions.iziSize.width,
              minHeight: IZIDimensions.iziSize.height,
            ),
            color: ColorResources.BACKGROUND,
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Text(
                    "Danh sách sản phẩm đối ứng",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H5,
                      color: ColorResources.BLACK,
                    ),
                  ),
                ),
                Expanded(
                  child: IZISmartRefresher(
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    refreshController: controller.refreshController,
                    enablePullDown: true,
                    isLoading: false,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: IZICardReciprocalDetails(
                            sanPham: 'TST : Bộ Tam Sơn Thất',
                            soLuong: '4',
                            giaTien: "3.200.000 đ",
                            tongTien: "3.200.000 đ",
                            type: IZITypeReciprocalDetails.CHUA_DUYET,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
