import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Điều khoản và chính sách"),
      body: Center(
        child: Text("Điều khoản và chính sách")
      ),
    );
  }
}