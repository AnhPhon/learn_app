import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_controller.dart';

class V2RecruimentNewsCard extends GetView<V2RecruitmentController> {
  V2RecruimentNewsCard({Key? key, required this.tuyenDungResponse})
      : super(key: key);
  TuyenDungResponse tuyenDungResponse = TuyenDungResponse();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V2RecruitmentController(),
        builder: (V2RecruitmentController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_SMALL),
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
                            Text(
                              tuyenDungResponse.idNoiLamViec!.ten ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                  shadows: boxShadowText),
                            )
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
                                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Text(tuyenDungResponse.tieuDe.toString(),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.monetization_on,
                                                  size: Dimensions
                                                      .ICON_SIZE_DEFAULT),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: Dimensions
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: Text(
                                                    tuyenDungResponse
                                                        .idMucLuongDuKien!
                                                        .tieuDe
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_DEFAULT,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          if (tuyenDungResponse.isUngTuyen ==
                                              true)
                                            Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  child: Text('Đã ứng tuyển',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_DEFAULT,
                                                          color: ColorResources
                                                              .RED)),
                                                ),
                                              ],
                                            )
                                          else
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.access_time_rounded,
                                                    size: Dimensions
                                                        .ICON_SIZE_DEFAULT,
                                                    color:
                                                        ColorResources.BLACK),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .only(
                                                      left: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  child: Text(
                                                      controller
                                                          .onCutString(
                                                              tuyenDungResponse
                                                                  .idHinhThucLamViec!
                                                                  .tieuDe
                                                                  .toString())
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      )),
                                                ),
                                              ],
                                            )
                                        ],
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
