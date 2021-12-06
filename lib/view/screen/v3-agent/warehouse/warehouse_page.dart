import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/screen/v3-agent/warehouse/warehouse_controller.dart';

class V3WarehousePage extends GetView<V3WarehouseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3WarehouseController>(
      init: V3WarehouseController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: (controller.khoHangDaiLyList.isEmpty)
                ? Center(
                    child: Text(
                      "Bạn chưa có kho hàng, vui lòng vào mục thông tin cửa hàng để tạo kho!",
                      textAlign: TextAlign.center,
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                  )
                : Column(
                    children: [
                      //search bar
                      InputWidget(
                        hintText: "Tìm kiếm",
                        suffixIcon: Icon(
                          (controller.isSearched) ? Icons.close : Icons.search,
                          size: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                        suffixIconTap: () {
                          (controller.isSearched)
                              ? controller.clearSearch(context)
                              : controller.btnSearch(context);
                        },
                        textEditingController: controller.searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) => controller.btnSearch(context),
                        width: double.infinity,
                        isBorder: false,
                        fillColor: ColorResources.WHITE,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Divider(
                          height: 0,
                          color: ColorResources.GREY,
                        ),
                      ),

                      //dropdown warehouse
                      DropDownButton1<KhoHangDaiLyResponse>(
                        hint: "Chọn kho hàng",
                        value: controller.khoHangDaiLyResponse,
                        onChanged: (val) => controller.onChangedKhoHang(val!),
                        data: controller.khoHangDaiLyList,
                        width: double.infinity,
                        fillColor: ColorResources.WHITE,
                        isBorder: false,
                      ),

                      //item
                      Expanded(
                        child: _item(context),
                      ),
                    ],
                  ),
            floatingActionButton: (controller.khoHangDaiLyList.isEmpty)
                ? const SizedBox.shrink()
                : actionButton(controller: controller),
          ),
        );
      },
    );
  }

  ///
  ///item
  ///
  Widget _item(
    BuildContext context,
  ) {
    return GetBuilder<V3WarehouseController>(builder: (controller) {
      if (controller.isLoadingProduct) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.isLoadingSearch) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: controller.nhapKhoHangDaiLyList.isNotEmpty,
        onRefresh: () => controller.onRefresh(context),
        onLoading: () => controller.onLoading(context),
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: "Kéo lên để tải thêm dữ liệu",
        ),
        child: (controller.nhapKhoHangDaiLyList.isEmpty)
            ? const Center(
                child: Text("Kho hàng trống"),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.nhapKhoHangDaiLyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return (controller.nhapKhoHangDaiLyList[index].idSanPham ==
                          null)
                      ? const SizedBox.shrink()
                      : Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimensions.MARGIN_SIZE_SMALL,
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),
                          padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_SMALL,
                          ),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_DEFAULT,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.BORDER_RADIUS_SMALL,
                                      ),
                                      child: FadeInImageCustom(
                                        urlImage: controller
                                            .nhapKhoHangDaiLyList[index]
                                            .idSanPham!
                                            .hinhAnhDaiDien
                                            .toString(),
                                        height: .15,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.MARGIN_SIZE_SMALL,
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: SizedBox(
                                      height: DeviceUtils.getScaledHeight(
                                          context, .08),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.nhapKhoHangDaiLyList[index].idSanPham!.maSanPham} - ${controller.nhapKhoHangDaiLyList[index].idSanPham!.ten}",
                                            maxLines: 2,
                                            style: Dimensions
                                                .fontSizeStyle16w600(),
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .MARGIN_SIZE_EXTRA_SMALL,
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Text((controller
                                                            .nhapKhoHangDaiLyList[
                                                                index]
                                                            .soLuong ==
                                                        "0")
                                                    ? "Hết hàng"
                                                    : "${controller.nhapKhoHangDaiLyList[index].soLuong} sản phẩm"),
                                                VerticalDivider(
                                                  color: ColorResources.BLACK
                                                      .withOpacity(.7),
                                                ),
                                                Text(
                                                  "${PriceConverter.convertPrice(
                                                    context,
                                                    double.parse(
                                                      controller
                                                          .nhapKhoHangDaiLyList[
                                                              index]
                                                          .idSanPham!
                                                          .gia
                                                          .toString(),
                                                    ),
                                                  )} đ",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                height: 20,
                                color: ColorResources.BLACK.withOpacity(.7),
                              ),

                              //product code
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nhập kho: ${DateConverter.formatDateTime(
                                      controller
                                          .nhapKhoHangDaiLyList[index].createdAt
                                          .toString(),
                                    )}",
                                  ),
                                  Text(
                                    "Quy cách: ${controller.nhapKhoHangDaiLyList[index].idSanPham!.quyCach}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
      );
    });
  }

  ///
  ///floatingActionButton
  ///
  Widget actionButton({required V3WarehouseController controller}) {
    return InkWell(
      onTap: () => controller.onToReceiveClick(),
      child: Material(
        color: ColorResources.LIGHT_SKY_BLUE,
        elevation: 5,
        borderRadius: BorderRadius.circular(50),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              decoration: const BoxDecoration(
                color: ColorResources.PRIMARY,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: Dimensions.ICON_SIZE_LARGE,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Text(
                "Nhập kho",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
