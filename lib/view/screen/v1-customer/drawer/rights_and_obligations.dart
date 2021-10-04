import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/appbar/large_size_app_bar.dart';

class RightsAndObligations extends StatelessWidget {
  const RightsAndObligations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Quyền và nghĩa vụ của FSS"),
      body: Center(
        child: Text("Quyền và nghĩa vụ của FSS")
      ),
    );
  }
}