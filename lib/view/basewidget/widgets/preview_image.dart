import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

// ignore: must_be_immutable
class ReviewImagePage extends StatefulWidget {
  String? image;
  ReviewImagePage({this.image});

  @override
  PreviewImageState createState() => PreviewImageState();
}

class PreviewImageState extends State<ReviewImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Review hình ảnh",
      ),
      backgroundColor: ColorResources.BLACK,
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: PhotoView(
          imageProvider: NetworkImage(widget.image ?? Images.location_example),
        ),
      ),
    );
  }
}
