import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/appbar/large_size_app_bar.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Điều khoản và chính sách"),
      body: Center(
        child: Text("Điều khoản và chính sách")
      ),
    );
  }
}