import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

import '../candidate_controller.dart';

class RecruimentNewsCard extends GetView<V1CandidateController> {
  RecruimentNewsCard({Key? key, required this.tuyenDungResponse})
      : super(key: key);
  TuyenDungResponse tuyenDungResponse;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V1CandidateController(),
        builder: (V1CandidateController controller) {
          return Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: BoxShadowWidget(
              child: SizedBox(
                height: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                                child: FadeInImageCustom(
                                  width:
                                      DeviceUtils.getScaledHeight(context, 1),
                                  height:
                                      DeviceUtils.getScaledHeight(context, .5),
                                  urlImage: tuyenDungResponse.hinhAnhDaiDien
                                      .toString(),
                                )),
                            
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_SMALL),
                                child: Text(tuyenDungResponse.tieuDe.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_LARGE)),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.PADDING_SIZE_SMALL),
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                          color: ColorResources.GREY,
                                          fontWeight: FontWeight.w500),
                                      child: SizedBox(
                                        width: DeviceUtils.getScaledWidth(
                                            context, 1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(tuyenDungResponse
                                                .idMucLuongDuKien
                                                .toString()),
                                            if (tuyenDungResponse
                                                    .idTrangThaiTuyenDung
                                                    .toString() ==
                                                app_constants
                                                    .TUYEN_DUNG_TRANG_THAI_TIN_CHUA_DUYET)
                                              const Text(
                                                "Tin chưa duyệt",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: ColorResources.RED),
                                              )
                                            else
                                              const Text(
                                                "Tin đã duyệt",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: ColorResources.GREEN,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }
}
