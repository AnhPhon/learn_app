import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_tin_tuc_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';

import 'news_categories_controller.dart';

class V2NewsCategoriesPage extends StatefulWidget {
  final DanhMucTinTucResponse danhMucTinTucList;

  const V2NewsCategoriesPage({Key? key, required this.danhMucTinTucList})
      : super(key: key);

  @override
  _V2NewsCategoriesPageState createState() => _V2NewsCategoriesPageState();
}

class _V2NewsCategoriesPageState extends State<V2NewsCategoriesPage>
    with AutomaticKeepAliveClientMixin {
  V2NewsCategoriesController? controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        Get.put(V2NewsCategoriesController(), tag: widget.key.toString());
    controller!.danhMucTinTucList = widget.danhMucTinTucList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!mounted) return const SizedBox();
    return SmartRefresher(
      key: UniqueKey(),
      controller: controller!.refreshController,
      enablePullUp: true,
      onLoading: controller!.onLoading,
      onRefresh: controller!.onRefresh,
      child: Obx(
        () => _itemList(),
      ),
    );
  }

  ///
  ///item list
  ///
  Widget _itemList() {
    return (controller!.tinTucModelList.isNotEmpty)
        ? SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller!.tinTucModelList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: ItemListWidget(
                        onTap: () =>
                            controller!.onNewsDetailClick(index: index),
                        urlImage: controller!.tinTucModelList[index].hinhAnh
                            .toString(),
                        title: controller!.tinTucModelList[index].tieuDe
                            .toString(),
                        rowText1: DateConverter.formatDateTime(
                          controller!.tinTucModelList[index].createdAt
                              .toString(),
                        ),
                        icon1: const Icon(
                          Icons.calendar_today_outlined,
                          color: ColorResources.GREY,
                        ),
                        colorRowText1: ColorResources.GREY,
                        rowText2: controller!.tinTucModelList[index].luotXem
                            .toString(),
                        icon2: const Icon(
                          Icons.remove_red_eye,
                          color: ColorResources.GREY,
                        ),
                        colorRowText2: ColorResources.GREY,
                        isSpaceBetween: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        : Container();
  }
}
