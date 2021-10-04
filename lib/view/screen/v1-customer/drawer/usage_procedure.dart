import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/appbar/large_size_app_bar.dart';

class UsageProcedure extends StatelessWidget {
  const UsageProcedure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Quy trình sử dụng vào giao dịch"),
      body: Center(
        child: Text("Quy trình sử dụng vào giao dịch")
      ),
    );
  }
}