import 'package:flutter/material.dart';
import 'package:template/utils/images_path.dart';

class IZICard extends StatelessWidget {
  const IZICard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImagesPath.logo,height: 150,width: 150),
        Text("Nội dùng 1"),
        Text("Nội dùng 1"),
        Text("Nội dùng 1"),
      ],
    );
  }
}
