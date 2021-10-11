import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class UsageProcedure extends StatelessWidget {
  const UsageProcedure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Quy trình sử dụng vào giao dịch"),
      body: Center(
        child: Text("Quy trình sử dụng vào giao dịch")
      ),
    );
  }
}