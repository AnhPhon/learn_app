import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
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
        return Scaffold(
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
                  Icons.search,
                  // (controller.isSearched) ? Icons.close : Icons.search,
                  size: Dimensions.ICON_SIZE_DEFAULT,
                ),
                suffixIconTap: () {
                  // (controller.isSearched)
                  //     ? controller.clearSearch(context)
                  //     : controller.btnSearch(context);
                },
                textEditingController: controller.searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {},
                // => controller.btnSearch(context),
                width: double.infinity,
                allowEdit: controller.taiKhoan.isNotEmpty,
                isBorder: false,
                fillColor: ColorResources.WHITE,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
              ),

              //list khach hang
              Expanded(
                child: (controller.taiKhoan.isEmpty)
                    ? const Center(
                        child: Text("Không có dữ liệu"),
                      )
                    : SmartRefresher(
                        controller: controller.refreshController,
                        enablePullUp: true,
                        onRefresh: controller.onRefresh,
                        onLoading: controller.onLoading,
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.taiKhoan.values.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                      left: Dimensions.PADDING_SIZE_DEFAULT,
                                      right: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    child: ItemListWidget(
                                      title: controller.taiKhoan.values
                                          .toList()[index]
                                          .hoTen
                                          .toString(),
                                      iconSubTitle: const Icon(
                                        Icons.location_on,
                                        size: Dimensions.ICON_SIZE_SMALL,
                                      ),
                                      subTitle:
                                          "${controller.taiKhoan.values.toList()[index].idPhuongXa!.ten}, ${controller.taiKhoan.values.toList()[index].idQuanHuyen!.ten}, ${controller.taiKhoan.values.toList()[index].idTinhTp!.ten}",
                                      icon1: const Icon(
                                        Icons.phone_iphone_outlined,
                                        size: Dimensions.ICON_SIZE_SMALL,
                                      ),
                                      rowText1: controller.taiKhoan.values
                                          .toList()[index]
                                          .soDienThoai,
                                      onTap: () =>
                                          controller.onCustomerDetailClick(
                                              taiKhoanResponse: controller
                                                  .taiKhoan.values
                                                  .toList()[index]),
                                      urlImage: controller.taiKhoan.values
                                          .toList()[index]
                                          .hinhDaiDien
                                          .toString(),
                                      boxShadow: boxShadowALitle,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
