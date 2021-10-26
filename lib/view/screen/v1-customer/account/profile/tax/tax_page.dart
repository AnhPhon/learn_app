import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/account/profile/tax/tax_controller.dart';

class V1TaxPage extends GetView<V1TaxController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1TaxController>(
      init: V1TaxController(),
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
              //title
              const Label(
                label: "Mã số thuế",
                obligatory: true,
                horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
              ),

              //input
              InputWidget(
                width: .9,
                textEditingController: controller.taxController,
                hintText: "Nhập mã số thuế",
                allowEdit: controller.dangKyThueResponse == null,
              ),

              //title
              const Label(
                label: "Tải hình ảnh bản cứng",
                obligatory: true,
                horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
              ),

              //upload image
              _uploadImage(context, controller),

              const Spacer(),

              //btn
              if (controller.dangKyThueResponse == null)
                BtnCustom(
                  onTap: () => controller.onBtnDoneClick(context),
                  color: ColorResources.PRIMARY,
                  text: "Hoàn thành",
                  width: DeviceUtils.getScaledWidth(context, .9),
                ),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(BuildContext context, V1TaxController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_LARGE,
      ),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      height: DeviceUtils.getScaledHeight(context, .158),
      child: Align(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: (controller.dangKyThueResponse != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dangKyThueResponse!.hinhAnhs!.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        image: controller.dangKyThueResponse!.hinhAnhs![index]
                            .toString(),
                        height: DeviceUtils.getScaledHeight(context, .122),
                        width: DeviceUtils.getScaledWidth(context, .254),
                        fit: BoxFit.fill,
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder,
                          height: DeviceUtils.getScaledHeight(context, .122),
                          width: DeviceUtils.getScaledWidth(context, .254),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                )
              : Row(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.taxImageList.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                              child: Image.file(
                                controller.taxImageList[index],
                                fit: BoxFit.fill,
                                height:
                                    DeviceUtils.getScaledHeight(context, .122),
                                width:
                                    DeviceUtils.getScaledWidth(context, .254),
                              ),
                            ),
                          );
                        }),
                    GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Image.asset(
                        Images.add_image,
                        height: DeviceUtils.getScaledHeight(context, .122),
                        width: DeviceUtils.getScaledWidth(context, .254),
                        fit: BoxFit.fill,
                        color: ColorResources.PRIMARY,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
