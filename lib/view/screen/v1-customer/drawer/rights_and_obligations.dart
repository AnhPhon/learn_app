import 'package:flutter/material.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class RightsAndObligations extends StatelessWidget {
  const RightsAndObligations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Quyền và nghĩa vụ của FSS"),
      body: Center(
        child: Text("Quyền và nghĩa vụ của FSS")
      ),
    );
  }
}