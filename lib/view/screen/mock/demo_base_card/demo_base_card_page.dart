import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/mock/demo_base_card/demo_base_card_controller.dart';

class DemoBaseCardPage extends GetView<DemoBaseCardController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Demo Base Card",
      ),
      body: GetBuilder(
        init: DemoBaseCardController(),
        builder: (DemoBaseCardController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
              horizontal: IZIDimensions.SPACE_SIZE_2X,
            ),
            color: ColorResources.BACKGROUND,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Payment",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      row1Left: "2123123FGS4312",
                      row1Right: "-500.000 VN??",
                      row2Left: "Thanh to??n ????n h??ng ??H001",
                      row3Left: "26/09/2021 15:30",
                      row3Right: "Th??nh c??ng",
                      statusMoney: IZIStatusMoney.DRAW,
                      statusPayment: IZIStatusPayment.DONE,
                      cardType: IZICardType.CARD_PAYMENT,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  type: IZIListViewType.GRIDVIEW,
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "S??m D??y Ng???c Linh T????i/Kh??",
                      row2Left: "?? 100.000",
                      row3Left: "??50.000",
                      row3Right: "???? b??n 800",
                      statusMoney: IZIStatusMoney.DRAW,
                      statusPayment: IZIStatusPayment.DONE,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Outline",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 320,
                  type: IZIListViewType.GRIDVIEW,
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "TRANH ???? QU??",
                      statusMoney: IZIStatusMoney.DRAW,
                      statusPayment: IZIStatusPayment.DONE,
                      cardType: IZICardType.CARD_OUTLINE,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Voucher",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      row1Left: "2123123FGS4312",
                      row1Right: "-500.000 VN??",
                      row2Left: "??i???u ki???n:\n????n t???i thi???u 5.000.000?? ",
                      row3Left: "H???n s??? d???ng: 25/12/2021",
                      statusMoney: IZIStatusMoney.DRAW,
                      statusPayment: IZIStatusPayment.DONE,
                      cardType: IZICardType.CARD_VOUCHER,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Notification",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "?????u t??",
                      row2Right: "Th??? ba, 16/11",
                      row2Left: "S??m d??y ng???c linh",
                      row3Left: "Lorem Ipsum is simply dummy text of the printing",
                      cardType: IZICardType.CARD_NOTIFICATION,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card News",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "??u ????i t??? H?? N???i Safe Food",
                      row1Right: "Th??? ba, 20/11",
                      row2Left: "Khuy???n m??i Combo H??? Tr??? ??i???u Tr??? Suy Nh?????c C?? Th???",
                      cardType: IZICardType.CARD_NEWS,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Contribution",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "S??? ti???n g??p v???n",
                      row2Left: "20.000.000 ??",
                      cardType: IZICardType.CARD_CONTRIBUTION,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Withdrawal",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "MS001 - S??? ?????u t?? 1 th??ng",
                      row2Left: "Ng??y h???t h???n: 22/12/2021",
                      cardType: IZICardType.CARD_WITHDRAWAL,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Circle",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "N???p ti???n",
                      cardType: IZICardType.CARD_CIRCLE,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card News",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://i.pinimg.com/originals/17/ce/7d/17ce7d9224dee7dccddd57836ab345a2.jpg",
                      row1Left: "??u ????i t??? H?? N???i Safe Food",
                      row1Right: "Th??? ba, 20/11",
                      row2Left: "Khuy???n m??i Combo H??? Tr??? ??i???u Tr??? Suy Nh?????c C?? Th???",
                      cardType: IZICardType.CARD_NEWS,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Capital Contribution",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      urlImage: "https://banner2.cleanpng.com/20180406/yjq/kisspng-computer-icons-saving-clip-art-piggy-bank-5ac788e259bfc9.6206916415230261463676.jpg",
                      row1Left: "1 tu???n",
                      row2Left: "L??i su???t 0.2%/ n??m",
                      groupValue: 1,
                      valRadio: 1,
                      cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIText(
                    text: "Demo Card Capital Contact",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IZIListView(
                  itemCount: 2,
                  builder: (index) {
                    return IZICard(
                      title: "An Gia B???o",
                      row1Left: "An Gia B???o",
                      row2Left: "0961225417",
                      groupValue: 1,
                      valRadio: 1,
                      cardType: IZICardType.CARD_CONTACT,
                      actions: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.message,
                            color: ColorResources.GREEN,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.call,
                            color: ColorResources.GREEN,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
