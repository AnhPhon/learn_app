import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/screen/v3-agent/account/customer_management/customer_management_controller.dart';

class V3CustomerManagementPage extends GetView<V3CustomerManagementController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3CustomerManagementController>(
      init: V3CustomerManagementController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //search bar
                InputWidget(
                  hintText: "Nhập tên khách hàng cần tìm lịch sử giao dịch",
                  suffixIcon: Icon(
                    (controller.isSearched) ? Icons.close : Icons.search,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  suffixIconTap: () {
                    (controller.isSearched)
                        ? controller.clearSearch(context)
                        : controller.onSearch(context);
                  },
                  textEditingController: controller.searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => controller.onSearch(context),
                  width: double.infinity,
                  isBorder: false,
                  fillColor: ColorResources.WHITE,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                ),

                if (controller.isLoadingSearch)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  //list khach hang
                  Expanded(
                    child: (controller.taiKhoanList.isEmpty)
                        ? const Center(
                            child: Text("Không có dữ liệu"),
                          )
                        : SmartRefresher(
                            controller: controller.refreshController,
                            enablePullUp: controller.taiKhoanList.isNotEmpty,
                            onRefresh: () => controller.onRefresh(context),
                            onLoading: () => controller.onLoading(context),
                            footer: const ClassicFooter(
                              loadingText: "Đang tải...",
                              noDataText: "Không có dữ liệu",
                              canLoadingText: "Kéo lên để tải thêm dữ liệu",
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.taiKhoanList.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                            top: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL,
                                            left:
                                                Dimensions.PADDING_SIZE_DEFAULT,
                                            right:
                                                Dimensions.PADDING_SIZE_DEFAULT,
                                          ),
                                          child: _itemList(
                                            context,
                                            onTap: () => controller
                                                .onCustomerDetailClick(
                                                    taiKhoanResponse: controller
                                                        .taiKhoanList[index]),
                                            urlImage: controller
                                                .taiKhoanList[index].hinhDaiDien
                                                .toString(),
                                            title: controller
                                                .taiKhoanList[index].hoTen
                                                .toString(),
                                            subTitle:
                                                "${controller.taiKhoanList[index].idPhuongXa}, ${controller.taiKhoanList[index].idQuanHuyen}, ${controller.taiKhoanList[index].idTinhTp}",
                                            iconSubTitle: const Icon(
                                              Icons.location_on,
                                              size: Dimensions.ICON_SIZE_SMALL,
                                            ),
                                            iconRowText: const Icon(
                                              Icons.phone_iphone_outlined,
                                              size: Dimensions.ICON_SIZE_SMALL,
                                            ),
                                            rowText: controller
                                                .taiKhoanList[index].soDienThoai
                                                .toString(),
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///image
  ///
  Widget _image({required String urlImage}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.BORDER_RADIUS_EXTRA_SMALL,
      ),
      child: FadeInImageCustom(
        urlImage: urlImage.toString(),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

  ///
  ///item list
  ///
  Widget _itemList(
    BuildContext context, {
    required VoidCallback onTap,
    required String urlImage,
    required String title,
    required String subTitle,
    required Icon iconSubTitle,
    required Icon iconRowText,
    required String rowText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
        ),
        height: DeviceUtils.getScaledHeight(context, .13),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: boxShadowALitle,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: _image(urlImage: urlImage),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            iconSubTitle,
                            const SizedBox(
                              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                            ),
                            Flexible(
                              child: Text(
                                subTitle.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        iconRowText,
                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                        ),
                        Text(
                          rowText,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
