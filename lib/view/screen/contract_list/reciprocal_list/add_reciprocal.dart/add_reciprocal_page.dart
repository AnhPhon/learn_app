import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/add_reciprocal.dart/add_reciprocal_controller.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/add_reciprocal.dart/components/izi_drop_dow_button.dart';

class AddReciprocalPage extends GetView<AddReciprocalController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: IZIScreen(
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
          title: "Thêm đối ứng",
        ),
        body: GetBuilder(
            init: AddReciprocalController(),
            builder: (AddReciprocalController controller) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Loại đối ứng
                    IZIDropDownButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      data: ["TST 3 triệu 2", "TST 3 triệu 1", "TST 3 triệu 3"],
                      value: "TST 3 triệu 2",
                      isRequired: true,
                      label: "Loại đối ứng",
                      onChanged: (val) {},
                    ),

                    //Số tiền đối ứng
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: IZIInput(
                        allowEdit: false,
                        min: 0,
                        borderRadius: IZIDimensions.BORDER_RADIUS_2X,
                        type: IZIInputType.PRICE,
                        label: "Số tiền đối ứng",
                        isRequired: true,
                      ),
                    ),

                    //Danh sách sản phẩm
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: Text(
                        "Danh sách sản phẩm",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.SPACE_SIZE_4X,
                          IZIDimensions.SPACE_SIZE_2X,
                          IZIDimensions.SPACE_SIZE_4X,
                          IZIDimensions.SPACE_SIZE_5X * 2.5,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          boxShadow: IZIOther().boxShadow,
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_3X,
                          ),
                        ),
                        child: IZISmartRefresher(
                          onLoading: controller.onLoading,
                          onRefresh: controller.onRefresh,
                          refreshController: controller.refreshController,
                          enablePullDown: true,
                          isLoading: false,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                width: IZIDimensions.iziSize.width,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              IZIDimensions.SPACE_SIZE_2X,
                                            ),
                                            child: IZIImage(
                                              ImagesPath.logoMomo,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Sản phẩm 1",
                                                  style: TextStyle(
                                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                                    color: ColorResources.BLACK,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                                Container(
                                                  height: IZIDimensions.SPACE_SIZE_2X,
                                                ),
                                                Text(
                                                  "100.000 ₫ x 1",
                                                  style: TextStyle(
                                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                    color: ColorResources.BLACK.withOpacity(.7),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Divider(
                                        color: ColorResources.BLACK.withOpacity(.8),
                                        thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        widgetBottomSheet: //Button xác nhận
            Container(
          color: ColorResources.BACKGROUND,
          padding: EdgeInsets.fromLTRB(
            IZIDimensions.SPACE_SIZE_4X,
            0,
            IZIDimensions.SPACE_SIZE_4X,
            IZIDimensions.SPACE_SIZE_2X,
          ),
          child: IZIButton(
            margin: const EdgeInsets.all(0),
            onTap: () {},
            label: "Thêm mới",
          ),
        ),
      ),
    );
  }
}
