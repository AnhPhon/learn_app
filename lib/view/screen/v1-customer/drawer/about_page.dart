import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Giới thiệu"),
      body: Center(
        child: Text("Giới thiệu")
      ),
    );
  }
}