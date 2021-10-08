
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_controller.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/candicate_card.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/recruiment_news_card.dart';

class V1CandidatePage extends GetView<V1CandidateController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tuyển dụng ứng viên"),
      body: GetBuilder(
        builder: (V1CandidateController controller) {
          return controller.currentIndex == 0 ?  news(context) : listOfCandidates(context, controller: controller);
        },
      ),
      floatingActionButton: GetBuilder(
        builder: (V1CandidateController controller) {
          return controller.currentIndex == 0 ? FloatingActionButton(
            onPressed: controller.onClickFloatButton,
            tooltip: "Tạo đơn dịch vụ",
            backgroundColor: ColorResources.PRIMARYCOLOR,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 5,
            child: const Icon(Icons.create, color: ColorResources.WHITE,),
          ) : Container();
        },
      )
    );
  }


  ///
  /// Tin tuyển dụng
  ///
  Widget news(BuildContext context){
    return Column(
      children: [
        // Tab bar
        tabBarWidget(context: context, controller: controller),
        // DANH SÁCH TIN TUYỂN DỤNG
        Expanded(
          child: SizedBox(
            height: DeviceUtils.getScaledHeight(context,1),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return RecruimentNewsCard(index: index);
              },
            ),
          ),
        )
      ],
    );
  }

  ///
  /// Danh sách ứng tuyển
  ///
  Widget listOfCandidates(BuildContext context, { required V1CandidateController controller}){
    return SingleChildScrollView(
      child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Tab bar
                tabBarWidget(context: context, controller: controller),
                // Tìm kiếm
                search(context,controller: controller),
                // Bộ lọc
                filter(context,controller: controller),
                // dánh sách ứng viên
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context,1),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          controller.onClickProfile();
                        },
                        child: const CandidateCard(showEmailAndPass: false,)
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  ///
  /// Khi chọn tab bar
  ///
    Widget onSelectedTab(BuildContext context,{required String title, required int index, required bool isLeft}) {
      return GestureDetector(
        onTap: () {
          controller.onChangeTab(index);
        },
        child: Container(
              alignment: Alignment.center,
              height: 50,
              width: (DeviceUtils.getScaledWidth(context, 1).roundToDouble() / 2) - Dimensions.PADDING_SIZE_DEFAULT,
              decoration: BoxDecoration(
                color: index == controller.currentIndex ? ColorResources.PRIMARYCOLOR : ColorResources.WHITE,
                borderRadius: isLeft ? const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)
                ) : const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)
                ),
                boxShadow: boxShadowMedium
              ),
              child: Text(title, style: TextStyle(
                  color: controller.currentIndex == index ? ColorResources.WHITE : ColorResources.GREY,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
        ),
      );
    }

    ///
    /// Thanh chọn tab
    ///
    Widget tabBarWidget({required BuildContext context , required V1CandidateController controller}){
      return Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT
        ),
        child: Container(
          alignment: Alignment.center,
          width: DeviceUtils.getScaledWidth(context, 1).roundToDouble(),
          height: 60,
          child: GetBuilder<V1CandidateController>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  onSelectedTab(context,title:"Tin tuyển dụng",index : 0, isLeft: true),
                  onSelectedTab(context,title:"Danh sách ứng viên",index: 1, isLeft: false),
                ],
              );
            },
          ),
        ),
      );
    }
    

    Widget search(BuildContext context, {required V1CandidateController controller}){
      return Padding(
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            textAlignVertical: TextAlignVertical.top,
            controller: controller.searchController,
            onChanged: (val){},
            decoration: InputDecoration(
              suffixIcon: GestureDetector(child: const Icon(Icons.search)),
              contentPadding:const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL, vertical:Dimensions.PADDING_SIZE_DEFAULT ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              disabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              isDense: true,
              hintText: "Search",
              hintStyle: TextStyle(
                color: ColorResources.BLACK.withOpacity(0.5),
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
          )
        ),
      );
    }

    ///
    ///Bộ lọc
    ///
    Widget filter(BuildContext context, {required V1CandidateController controller}){
      return Container(
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT
        ),
        child: Wrap(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.showDialog();
                  },
                  child: DropDownButtonIcon<String>(
                    width: DeviceUtils.getScaledWidth(context, 0.25),
                    onChanged: (val){}, 
                    data: [], 
                    icon: const Icon(Icons.filter_alt_outlined, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Lọc",
                    dropIcon: Container(),
                    style: const TextStyle(
                      color: ColorResources.BLACK
                    ),
                  ),
                ),
                DropDownButtonIcon<String>(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.4),
                  onChanged: (val){}, 
                  data: [], 
                  icon: const Icon(Icons.location_on, size: Dimensions.ICON_SIZE_DEFAULT,),
                  hint: "Toàn quốc",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                children: [
                  DropDownButtonIcon<String>(
                    width: DeviceUtils.getScaledWidth(context, 0.45),
                    onChanged: (val){}, 
                    data: [], 
                    icon: const Icon(Icons.work, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Ngành nghề",
                  ),
                  DropDownButtonIcon<String>(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    width: DeviceUtils.getScaledWidth(context, 0.4),
                    onChanged: (val){}, 
                    data: [], 
                    icon: const Icon(Icons.person, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Giới tính",
                  ),
                ],
              ),
            ),
            // Kinh nghiêm trình độ
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                children: [
                  DropDownButtonIcon<String>(
                    width: DeviceUtils.getScaledWidth(context, 0.4),
                    onChanged: (val){}, 
                    data: [], 
                    icon: const Icon(Icons.score, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Kinh nghiệm",
                  ),
                  DropDownButtonIcon<String>(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    width: DeviceUtils.getScaledWidth(context, 0.45),
                    onChanged: (val){}, 
                    data: [], 
                    icon: const Icon(Icons.school_rounded, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Trình độ",
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
}




