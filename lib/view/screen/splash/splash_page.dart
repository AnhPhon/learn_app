import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';
import 'package:ticket_material/ticket_material.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({Key? key}) : super(key: key);
  List<String> data = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "m"];
  final keyList = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: const IZIAppBar(
        title: "Splash Page",
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return IZICard(
                    urlImage: "https://i.pinimg.com/originals/39/0d/32/390d32780732b33abc9de4a6c164c991.jpg",
                    marginCard: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_3X,
                    ),
                    row1Left: "Hot Contest Hot Contest Hot Contest",
                    row1Right: "Thứ ba, 16/11 Thứ ba, 16/11",
                    row2Right: "Hot Contest Title Hot Contest TitleHot Contest TitleHot Contest Title Hot Contest TitleHot Contest Title",
                    row2Left: "Hot Contest Title Hot Contest TitleHot Contest TitleHot Contest Title Hot Contest TitleHot Contest Title",
                    row3Left: "Lorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest TitleLorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest TitleLorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest Title",
                    row3Right: "Lorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest TitleLorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest TitleLorem Ipsum is simply dummy text of the printing Hot Contest TitleHot Contest Title",
                    cardType: IZICardType.CARD_NOTIFICATION,
                    icon: Icons.more_horiz_outlined,
                  );
                },
              ),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return IZICard(
                    urlImage: "https://i.pinimg.com/originals/39/0d/32/390d32780732b33abc9de4a6c164c991.jpg",
                    marginCard: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    row1Left: "Hot Contest ",
                    row1Right: "Thứ ba, 16/11",
                    row2Left: "Hot Contest Title",
                    row3Left: "Lorem Ipsum is simply dummy text of the printing",
                    cardType: IZICardType.CARD_VORCHER,
                    groupValue: 1,
                    valRadio: 1,
                  );
                },
              ),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return IZICard(
                    urlImage: "https://i.pinimg.com/originals/39/0d/32/390d32780732b33abc9de4a6c164c991.jpg",
                    marginCard: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    row1Left: "Hot Contest ",
                    row1Right: "Thứ ba, 16/11",
                    row2Left: "Hot Contest Title",
                    row3Left: "Lorem Ipsum is simply dummy text of the printing",
                    cardType: IZICardType.CARD_VORCHER,
                    onTap: () {
                      print("aaaaaaaa");
                    },
                  );
                },
              ),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return IZICard(
                    urlImage: "https://i.pinimg.com/originals/39/0d/32/390d32780732b33abc9de4a6c164c991.jpg",
                    marginCard: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    row1Left: "Ưu đãi từ Hà Nội Safe Food Ưu đãi từ Hà Nội Safe FoodƯu đãi từ Hà Nội Safe Food",
                    row1Right: "Thứ ba, 16/11 Thứ ba, 16/11 Thứ ba, 16/11",
                    row2Left: "Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể",
                    row3Left: "Lorem Ipsum is simply dummy text of the printing",
                    cardType: IZICardType.CARD_NEWS,
                    onTap: () {
                      print("aaaaaaaa");
                    },
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 420,
                      crossAxisCount: 2,
                      mainAxisSpacing: IZIDimensions.ONE_UNIT_SIZE * 20,
                      crossAxisSpacing: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    itemBuilder: (context, index) {
                      return IZICard(
                        marginCard: EdgeInsets.all(
                          IZIDimensions.ONE_UNIT_SIZE * 5,
                        ),
                        urlImage: "https://allnewplayers.com/wp-content/uploads/2021/08/maxresdefault-1.jpg",
                        row1Left: 'Sâm Dây Ngọc Linh Tươi/Khô',
                        row2Left: "100.000",
                        row3Left: "50.000",
                        row3Right: "900",
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 420,
                      crossAxisCount: 2,
                      mainAxisSpacing: IZIDimensions.ONE_UNIT_SIZE * 20,
                      crossAxisSpacing: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    itemBuilder: (context, index) {
                      return IZICard(
                        marginCard: EdgeInsets.all(
                          IZIDimensions.ONE_UNIT_SIZE * 5,
                        ),
                        urlImage: "https://allnewplayers.com/wp-content/uploads/2021/08/maxresdefault-1.jpg",
                        row1Left: 'Sâm Dây Ngọc Linh Tươi/Khô Sâm Dây Ngọc Linh Tươi/KhôSâm Dây Ngọc Linh Tươi/Khô',
                        row2Left: "100.000100.000100.000",
                        row3Left: "50.000100.000100.000",
                        row3Right: "9000",
                        cardType: IZICardType.CARD_OUTLINE,
                      );
                    }),
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Right: "Momo",
                row2Right: 'Ngô Trần Anh Phôn Ngô Trần Anh Phôn Ngô Trần Anh Phôn Ngô Trần Anh Phôn ',
                row3Right: "0961-225-417 0961 09610961 0961 0961 0961  ",
                cardType: IZICardType.CARD_TRANSFERS,
                onChanged1CardTransfer: (val) {
                  controller.phone = val;
                  print(controller.phone);
                },
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Left: "Số tiền góp vốn Số tiền góp vốn Số tiền góp vốn ",
                row2Left: "20.000.000 20.000.000 20.000.000 20.000.000 20.000.000 20.000.000 ",
                cardType: IZICardType.CARD_CONTRIBUTION,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IZICard(
                    widthCard: IZIDimensions.ONE_UNIT_SIZE * 250,
                    marginCard: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 10,
                    ),
                    row1Left: "Kỳ hạn Kỳ hạn Kỳ hạn Kỳ hạn Kỳ hạn ",
                    row2Left: "1 tháng 1 tháng 1 tháng 1 tháng 1 tháng 1 tháng 1 tháng ",
                    cardType: IZICardType.CARD_CONTRIBUTION,
                  ),
                  IZICard(
                    widthCard: IZIDimensions.ONE_UNIT_SIZE * 250,
                    marginCard: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 10,
                    ),
                    row1Left: "Lãi xuất Lãi xuất Lãi xuất Lãi xuất Lãi xuất ",
                    row2Left: "0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% 0.3% ",
                    cardType: IZICardType.CARD_CONTRIBUTION,
                  ),
                ],
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Left: "MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng ",
                row2Left: "22/12/2021 22/12/2021 22/12/2021 22/12/2021 22/12/2021 ",
                cardType: IZICardType.CARD_WITHDRAWAL,
                onTap: () {
                  print("Phone check");
                },
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Left: "MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng MS01 - Số tháng đầu tư 1 tháng ",
                row2Left: "22/12/2021 22/12/2021 22/12/2021 22/12/2021 22/12/2021 ",
                cardType: IZICardType.CARD_PAYMENT,
                onTap: () {
                  print("Phone check");
                },
                statusMoney: IZIStatusMoney.DRAW,
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Left: "MS01 OK",
                row2Left: "22/12/2021 22/12/2021 22/12/2021 22/12/2021 22/12/2021 ",
                cardType: IZICardType.CARD_CIRCLE,
                onTap: () {
                  print("Phone check");
                },
                icon: Icons.ac_unit_outlined,
              ),
              IZICard(
                marginCard: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                row1Left: "MS01 OK",
                row2Left: "22/12/2021 22/12/2021 22/12/2021 22/12/2021 22/12/2021 ",
                cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                onTap: () {
                  print("Phone check");
                },
                groupValue: 1,
                valRadio: 1,
                imageUrlType: IZIImageUrlType.NETWORK,
                icon: Icons.ac_unit_outlined,
                urlImage: "https://allnewplayers.com/wp-content/uploads/2021/08/0a8514fed79c41fc53a925ac9ea69712.jpg",
              ),
            ],
          );
        },
      ),
    );
  }
}
