import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';
import 'package:template/view/basewidget/appbar/search_app_bar.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/recruiment_news_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_controller.dart';


class V2RecruitmentPage extends GetView<V2RecruitmentController>{
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AppBarController(),
      builder: (AppBarController appbar) {
        return GetBuilder(
          builder: (V2RecruitmentController controller) {
            return Scaffold(
              appBar: SearchAppBarWidget(title: "Tin tuyển dụng", 
                searchController: controller.searchController,
                action: [
                  IconButton(icon: const Icon(Icons.history), color: ColorResources.WHITE,onPressed: (){
                    controller.onClickHistory();
                  },)
                ],
              ),
              body: appbar.isSearch ? filterProfile(context, controller: controller) : recruitment(context, controller: controller)
            );
          },
        );
      },
    );
  }


  Widget filterProfile(BuildContext context, {required V2RecruitmentController controller}){
    return Column(
      children: [
        filter(context, controller: controller),
        Expanded(
          child: SizedBox(
            height: DeviceUtils.getScaledHeight(context,1),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return V2RecruimentNewsCard(index: index);
              },
            ),
          ),
        )
      ],
    );
  }


  Widget recruitment(BuildContext context,{required V2RecruitmentController controller}){
    return Column(
      children: [
        tabBarWidget(context, controller: controller),
        Expanded(
          child: ListView.builder(
            itemCount: controller.currentIndex == 1 ? 3 : controller.currentIndex == 2 ? 5 : 7,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.onClickRecruitmentNews();
                },
                child: V2RecruimentNewsCard(index: index,)
              );
            },
          ),
        )
      ],
    );
  }

  // Khi chọn tab
    Widget onSelectedTab(BuildContext context,{required V2RecruitmentController controller, required String title, required int index, bool? isMT = false, bool? isSelectedMN = false}) {
      return GestureDetector(
        onTap: () {
          controller.onChangeTab(index);
        },
        child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble() / 3,
              decoration: BoxDecoration(
                borderRadius: isMT! ? null : 
                isSelectedMN! ? const BorderRadius.only(topRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL)) : 
                const BorderRadius.only(topLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL)),
                color: controller.currentIndex == index? ColorResources.PRIMARYCOLOR : ColorResources.WHITE,
                border: isMT ? const Border(
                  top:BorderSide(color: ColorResources.PRIMARYCOLOR),
                  bottom:BorderSide(color: ColorResources.PRIMARYCOLOR)
                ) : Border.all(color: ColorResources.PRIMARYCOLOR),
              ),
              child: Text(title, style: TextStyle(
                color: controller.currentIndex == index ? ColorResources.WHITE : ColorResources.BLACK,
                fontWeight: controller.currentIndex == index ? FontWeight.bold : FontWeight.normal,
              ),),
        ),
      );
    }

    ///
    /// Thanh tab bar
    ///
    Widget tabBarWidget(BuildContext context, {required V2RecruitmentController controller}){
      return Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context,1),
        height: DeviceUtils.getScaledHeight(context, 0.1),
        child: Container(
          alignment: Alignment.center,
          width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble(),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              onSelectedTab(context,title:"Tin hot",index: 0, controller: controller),
              onSelectedTab(context,title:"Mới nhất",index: 1, isMT: true, controller: controller),
              onSelectedTab(context,title:"Tuyển dụng",index: 2,isSelectedMN: true, controller: controller),
            ],
          )
        ),
      );
    }
    

    ///
    ///Bộ lọc
    ///
    Widget filter(BuildContext context, {required V2RecruitmentController controller}){
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
                    data: const[], 
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
                  width: DeviceUtils.getScaledWidth(context, 0.63),
                  onChanged: (val){}, 
                  data: const[], 
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
                    width: DeviceUtils.getScaledWidth(context, 0.47),
                    onChanged: (val){}, 
                    data: const[], 
                    icon: const Icon(Icons.work, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Ngành nghề",
                  ),
                  DropDownButtonIcon<String>(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    width: DeviceUtils.getScaledWidth(context, 0.4),
                    onChanged: (val){}, 
                    data: const[], 
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
                    data:const [], 
                    icon: const Icon(Icons.score, size: Dimensions.ICON_SIZE_DEFAULT,),
                    hint: "Kinh nghiệm",
                  ),
                  DropDownButtonIcon<String>(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    width: DeviceUtils.getScaledWidth(context, 0.45),
                    onChanged: (val){}, 
                    data: const[], 
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