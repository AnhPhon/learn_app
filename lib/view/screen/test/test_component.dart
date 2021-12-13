import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';
import 'package:template/view/screen/test/test_component_controller.dart';

class TestComponentPage extends GetView<TestComponentController> {
  TestComponentPage({Key? key}) : super(key: key);
  final keyList = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataTest = [
      {"image": "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", "lable": "Siêu nhân đỏ"},
      {"image": "https://i.pinimg.com/736x/b0/f5/d0/b0f5d018291db21c3a972cc575eb3659.jpg", "lable": "Siêu nhân xanh"},
      {"image": "https://i.pinimg.com/564x/6f/3b/8f/6f3b8f2937e5c326da3f327112cf819f.jpg", "lable": "Siêu nhân vàng"},
      {"image": "https://i.pinimg.com/564x/f1/43/64/f1436415a2a208043bdef80c73d66b4a.jpg", "lable": "Siêu nhân đen"},
      {"image": "https://hahoatien.edu.vn/tinhyeu/wp-content/uploads/2017/06/anh-chibi-sieu-nhan-sieu-anh-hung-dep-va-chat-nhat-23.jpg", "lable": "Siêu nhân trắng"},
      {"image": "https://i.pinimg.com/564x/f1/43/64/f1436415a2a208043bdef80c73d66b4a.jpg", "lable": "Siêu nhân hồng"},
      {"image": "https://i.pinimg.com/564x/f1/43/64/f1436415a2a208043bdef80c73d66b4a.jpg", "lable": "Siêu nhân tím"}
    ];
    final List<Map<String, String>> heoTest = [
      {"image": ImagesPath.capital_contribution_month, "lable": "Lãi suất 42%/tháng",'title':"1 tháng"},
      {"image": ImagesPath.capital_contribution_year, "lable": "Lãi suất 42%/năm",'title':"1 năm"},
      {"image": ImagesPath.capital_contribution_week, "lable": "Lãi suất 42%/tuần",'title':"1 tuần"},
    ];

    return IZIScreen(
      background: BackgroundAppBar(),
      appBar: const IZIAppBar(
        title: "Component",
      ),
      body: GetBuilder(
        init: TestComponentController(),
        builder: (TestComponentController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IZIText(
                text: "Input",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: IZIDimensions.FONT_SIZE_H1),
              ),

              Container(
                color: ColorResources.GREY.withOpacity(0.2),
                child: Column(
                  children: [
                    IZIText(text: "Số thực"),
                    IZIInput(
                      placeHolder: "Double",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.DOUBLE,
                      isBorder: true,
                    ),
                    IZIText(text: "Địa chỉ email"),
                    IZIInput(
                      placeHolder: "Email",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.EMAIL,
                    ),
                    IZIText(text: "Dạng số nguyên"),
                    IZIInput(
                      placeHolder: "Number",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.NUMBER,
                    ),
                    IZIText(text: "Dạng mật khẩu"),
                    IZIInput(
                      placeHolder: "Password",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.PASSWORD,
                    ),
                    IZIText(text: "Dạng số điện thoại"),
                    IZIInput(
                      placeHolder: "Phone",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.PHONE,
                    ),
                    IZIText(text: "Dạng tiền"),
                    IZIInput(
                      placeHolder: "Price",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.PRICE,
                    ),
                    IZIText(text: "Dạng text"),
                    IZIInput(
                      placeHolder: "Text",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.TEXT,
                    ),
                    IZIText(text: "Dạng có lable trên border"),
                    IZIInput(
                      placeHolder: "Label",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.TEXT,
                      isLegend: true,
                      isBorder: true,
                    ),
                    IZIText(text: "Dạng có label trên input"),
                    IZIInput(
                      placeHolder: "Label trên input",
                      allowEdit: true,
                      isRequired: true,
                      type: IZIInputType.TEXT,
                      label: "Label trên input",
                    ),
                    IZIText(text: "Dạng 2 nút tăng giảm"),
                    IZIInput(
                      placeHolder: "100",
                      allowEdit: false,
                      isRequired: true,
                      type: IZIInputType.INCREMENT,
                      isBorder: true,
                      max: 50,
                      min: 10,
                      onChanged: (val) {
                        print(val);
                      },
                      width: IZIDimensions.ONE_UNIT_SIZE * 500,
                      disbleError: true,
                    ),
                  ],
                ),
              ),

              IZIText(
                text: "Button",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: IZIDimensions.FONT_SIZE_H1),
              ),

              Container(
                // color:ColorResources.GREY.withOpacity(0.2),
                child: Column(
                  children: [
                    IZIText(text: "Hiển thị dialog"),
                    IZIButton(
                      icon: Icons.ac_unit,
                      label: "Hiển thị dialog",
                      onTap: () {
                        IZIDialog.showDialog(
                            lable: "Thông báo",
                            onConfirm: () {
                              IZIAlert.success(message: "Đã nhấn vào đông ý");
                            },
                            onCancel: () {
                              IZIAlert.success(message: "Đã nhấn vào từ chối");
                            },
                            description: 'Miêu tả');
                      },
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
                    ),
                    IZIText(text: "Button có icon"),
                    IZIButton(
                      icon: Icons.ac_unit,
                      label: "Check disible button mặc định",
                      onTap: () {
                        controller.checkButton();
                      },
                      type: IZIButtonType.DEFAULT,
                      isEnabled: controller.isButtonActive,
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
                    ),
                    IZIText(text: "Button có border"),
                    IZIButton(
                      icon: Icons.home,
                      label: "Trang chủ",
                      onTap: () {
                        controller.checkButton();
                      },
                      type: IZIButtonType.OUTLINE,
                      isEnabled: controller.isButtonActive,
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
                    ),
                    IZIText(text: "Button không có icon mặc định"),
                    IZIButton(
                      label: "Nút không có icon",
                      onTap: () {
                        controller.checkButton();
                      },
                      type: IZIButtonType.DEFAULT,
                      isEnabled: controller.isButtonActive,
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
                    ),
                    IZIText(text: "Button không có icon có border"),
                    IZIButton(
                      label: "Nút không có icon và có border",
                      onTap: () {
                        controller.checkButton();
                      },
                      type: IZIButtonType.OUTLINE,
                      isEnabled: controller.isButtonActive,
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
                    ),
                  ],
                ),
              ),

              IZIText(
                text: "Hình ảnh và tập tin",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: IZIDimensions.FONT_SIZE_H1),
              ),

              Container(
                // color:ColorResources.GREY.withOpacity(0.2),
                child: Column(
                  children: [
                    IZIText(text: "Chọn tập tin"),
                    IZIFile.file(onPikerFile: (val) {
                      IZIAlert.success(message: "Kết quả trả về ${val}");
                    }),
                    IZIText(text: "Chọn hình ảnh bằng gallery"),
                    IZIFile(
                        imageSource: ImageSource.gallery,
                        onPikerFile: (val) {
                          IZIAlert.success(message: "Kết quả trả về ${val}");
                        }),
                    IZIText(text: "Chọn hình ảnh bằng camera"),
                    IZIFile(
                        imageSource: ImageSource.camera,
                        onPikerFile: (val) {
                          IZIAlert.success(message: "Kết quả trả về ${val}");
                        }),
                  ],
                ),
              ),

              IZIText(
                text: "List view",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: IZIDimensions.FONT_SIZE_H1),
              ),
              IZIText(text: "List View hàng ngang"),
              IZIListView(
                itemCount: dataTest.length,
                physics: AlwaysScrollableScrollPhysics(),
                action: Text(
                  "Xem thêm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.CIRCLE_COLOR_BG3,
                  ),
                ),
                label: "Danh mục",
                scrollDirection: Axis.horizontal,
                padding: IZIDimensions.ONE_UNIT_SIZE * 10,
                builder: (index) {
                  return Container(
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    child: IZICard(
                      urlImage: dataTest[index]['image'],
                      row1Left: dataTest[index]['lable'],
                      // icon: Icons.access_alarm,
                      colorBG: ColorResources.CIRCLE_COLOR_BG3,
                      cardType: IZICardType.CARD_CIRCLE,
                      onTap: () {
                        IZIAlert.success(message: "Đã nhấn vào");
                      },
                    ),
                  );
                },
              ),

              IZIText(text: "List View hàng dọc"),
              IZIListView(
                itemCount: dataTest.length,
                action: Text(
                  "Xem thêm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.CIRCLE_COLOR_BG3,
                  ),
                ),
                label: "Danh mục",
                scrollDirection: Axis.vertical,
                padding: IZIDimensions.ONE_UNIT_SIZE * 10,
                builder: (index) {
                  return Container(
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    child: IZICard(
                      urlImage: dataTest[index]['image'],
                      row1Left: dataTest[index]['lable'],
                      // icon: Icons.access_alarm,
                      colorBG: ColorResources.CIRCLE_COLOR_BG3,
                      cardType: IZICardType.CARD_CIRCLE,
                      onTap: () {
                        IZIAlert.success(message: "Đã nhấn vào");
                      },
                    ),
                  );
                },
              ),

              IZIText(text: "List View con heo đất"),
              IZIListView(
                itemCount: heoTest.length,
                action: Text(
                  "Xem thêm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.CIRCLE_COLOR_BG3,
                  ),
                ),
                label: "Danh mục",
                scrollDirection: Axis.vertical,
                padding: IZIDimensions.ONE_UNIT_SIZE * 10,
                builder: (index) {
                  return Container(
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    child: IZICard(
                      urlImage: heoTest[index]['image'],
                      row1Left: heoTest[index]['title'],
                      row2Left: heoTest[index]['label'],
                      cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                      valRadio: index,
                      groupValue: controller.groupVal,
                      onChanged: (val) {
                        controller.onRadioChanged(index);
                      },
                    ),
                  );
                },
              ),

              IZIText(text: "Card liên hệ có icon"),
              IZICard(
                urlImage: "",
                row1Left: "Nguyễn Huỳnh Test",
                row2Left: "0123434737433",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_CONTACT,
                statusMoney: IZIStatusMoney.DRAW,
                colorBG: ColorResources.GREY,
                title: "A",
                actions: [
                  GestureDetector(
                    onTap: () {
                      IZIAlert.success(message: "Đã nhấn vào");
                    },
                    child: Icon(
                      Icons.message,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      color: ColorResources.CIRCLE_COLOR_BG4,
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.ONE_UNIT_SIZE * 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      IZIAlert.success(message: "Đã nhấn vào");
                    },
                    child: Icon(
                      Icons.phone_forwarded,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      color: ColorResources.CIRCLE_COLOR_BG4,
                    ),
                  ),
                ],
              ),

              IZIText(text: "Card liên hệ không có icon"),
              IZICard(
                urlImage: "",
                row1Left: "Nguyễn Huỳnh Test",
                row2Left: "0123434737433",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_CONTACT,
                statusMoney: IZIStatusMoney.DRAW,
                colorBG: ColorResources.GREY,
                title: "A",
              ),
              
              IZICard(
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "10000000000000000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.DRAW,
              ),

              IZICard(
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "1000000000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.AWAIT,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.RECHARGE,
                marginCard: EdgeInsets.symmetric(vertical: 10),
              ),

              IZICard(
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "10000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.FAIL,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.DRAW,
              ),

              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                width: IZIDimensions.ONE_UNIT_SIZE * 400,
                child: IZIImage.file(controller.fileImage),
              ),

              IZIText(text: "Image url rỗng"),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                width: IZIDimensions.ONE_UNIT_SIZE * 400,
                color: Colors.black,
                child: IZIImage(
                  "https://i.pinimg.com/originals/32/b8/36/32b836c010f35024aa63c8a7d7d97d58.jpg",
                  height: IZIDimensions.ONE_UNIT_SIZE * 100,
                  width: IZIDimensions.ONE_UNIT_SIZE * 100,
                ),
              ),

              IZIText(text: "Image url rỗng"),
              IZIImage(
                "",
                fit: BoxFit.fill,
                height: IZIDimensions.ONE_UNIT_SIZE * 300,
                width: IZIDimensions.ONE_UNIT_SIZE * 300,
              ),

              IZIText(text: "URL .svg"),

              IZIImage("https://raw.githubusercontent.com/dnfield/flutter_svg/7d374d7107561cbd906d7c0ca26fef02cc01e7c8/example/assets/flutter_logo.svg"),

              IZIText(text: "local .svg"),

              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 500,
                width: IZIDimensions.ONE_UNIT_SIZE * 500,
                color: Colors.red,
                child: IZIImage(
                  "assets/svg/410.svg",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
